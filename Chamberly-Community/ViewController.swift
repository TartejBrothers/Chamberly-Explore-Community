import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UIScrollViewDelegate, CommunityComponentDelegate {
    var trendingStackView: UIStackView?
    var recommendationsStackView: UIStackView?
    var myCommunityStackView: UIStackView?
    var exploreStackView: UIStackView?
    
    var trendingSubheading: UILabel?
    var recommendationsSubheading: UILabel?
    var myCommunitySubheading: UILabel?
    var exploreSubheading: UILabel?
    
    var communityStackView1: UIStackView?
    var communityStackView2: UIStackView?
    
    var exploreStackView1: UIStackView?
    var exploreStackView2: UIStackView?
    var selectedTabIndex = 0
    var scrollView: UIScrollView!
    var contentView: UIView!
    var numberOfComponents = 5
    var originalComponents: [CommunityComponent] = []
    
    var searchBar: UISearchBar!
    var searchResultsView: SearchResultsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader(in: view)
        setupSearchBar(in: view)
        setupTabs(in: view)
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        
        let headerStackView = UIStackView()
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        let communityImage = UIImageView(image: UIImage(named: "Header"))
        communityImage.contentMode = .scaleAspectFit
        headerStackView.addArrangedSubview(communityImage)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerStackView)

        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])

        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 120),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        trendingStackView = setupTrending(in: contentView, numberOfComponents: numberOfComponents)
        recommendationsStackView = setupRecommendations(in: contentView, numberOfComponents: numberOfComponents)
        myCommunityStackView = setupMyCommunity(in: contentView, numberOfComponents: numberOfComponents)
        exploreStackView = setupExplore(in: contentView, numberOfComponents: numberOfComponents)
        
        let contentWidth = UIScreen.main.bounds.width
        let contentHeight: CGFloat = 1450
        contentView.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
        showContent(for: selectedTabIndex)
        scrollView.delegate = self
        
        searchResultsView = SearchResultsView()
        searchResultsView?.translatesAutoresizingMaskIntoConstraints = false
        searchResultsView?.isHidden = true
        view.addSubview(searchResultsView!)
        
        NSLayoutConstraint.activate([
            searchResultsView!.topAnchor.constraint(equalTo: view.topAnchor),
            searchResultsView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultsView!.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func showSearchResults() {
        guard let searchResultsView = searchResultsView else { return }
        searchResultsView.removeFromSuperview()
        self.searchResultsView = SearchResultsView(frame: .zero)

        guard let searchResultsView = self.searchResultsView else { return }
        searchResultsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchResultsView)
        
        NSLayoutConstraint.activate([
            searchResultsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchResultsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.lowercased(), !searchText.isEmpty else {
            searchResultsView?.clearResults()
            searchResultsView?.isHidden = true
            showContent(for: selectedTabIndex)
            return
        }

        searchResultsView?.clearResults()

        let matchingComponents = originalComponents.filter { $0.headingLabelText.lowercased().contains(searchText) }

        if !matchingComponents.isEmpty {
            searchResultsView?.isHidden = false
            searchResultsView?.addCommunityComponents(matchingComponents)
        } else {
            searchResultsView?.isHidden = true
        }
        
        searchBar.text = nil
        showContent(for: selectedTabIndex)
    }

    class SearchResultsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        var collectionView: UICollectionView!
        var backButton: UIButton!
        var components: [CommunityComponent] = []
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupUI()
        }
        
        private func setupUI() {
            backgroundColor = .white
            
            let headerProfileStackView = UIStackView()
            headerProfileStackView.axis = .horizontal
            headerProfileStackView.spacing = 20
            headerProfileStackView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(headerProfileStackView)

            let communityImage = UIImageView(image: UIImage(named: "Header"))
            communityImage.contentMode = .scaleAspectFit
            communityImage.translatesAutoresizingMaskIntoConstraints = false
            headerProfileStackView.addArrangedSubview(communityImage)

            NSLayoutConstraint.activate([
                headerProfileStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                headerProfileStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                headerProfileStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20)
            ])
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.backgroundColor = .white
            collectionView.register(CommunityComponentCell.self, forCellWithReuseIdentifier: "CommunityComponentCell")
            addSubview(collectionView)

            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: headerProfileStackView.bottomAnchor, constant: 20),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

            backButton = UIButton(type: .system)
                    backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal) // Using system back icon
                    backButton.tintColor = UIColor(red: 0.478, green: 0.478, blue: 1.0, alpha: 1.0) // Adjusted color
                    backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
                    backButton.translatesAutoresizingMaskIntoConstraints = false
                    addSubview(backButton)

                    // Adjust constraints for all elements
                    NSLayoutConstraint.activate([
                        headerProfileStackView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
                        headerProfileStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0), // Adjusted leading anchor
                        headerProfileStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                        headerProfileStackView.heightAnchor.constraint(equalToConstant: 40),

                        backButton.centerYAnchor.constraint(equalTo: headerProfileStackView.centerYAnchor),
                        backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), // Adjusted leading anchor
                    ])
        }
        @objc func backButtonTapped() {
                
                self.isHidden = true
            }
        
        func addCommunityComponents(_ components: [CommunityComponent]) {
            self.components = components
            collectionView.reloadData()
        }
        
        func clearResults() {
            components.removeAll()
            collectionView.reloadData()
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return components.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommunityComponentCell", for: indexPath) as! CommunityComponentCell
            cell.communityComponent = components[indexPath.item]
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 200, height: 160)
        }
        
        class CommunityComponentCell: UICollectionViewCell {
            var communityComponent: CommunityComponent? {
                didSet {
                    if let component = communityComponent {
                        contentView.addSubview(component)
                        component.translatesAutoresizingMaskIntoConstraints = false
                        NSLayoutConstraint.activate([
                            component.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                            component.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                            component.topAnchor.constraint(equalTo: contentView.topAnchor),
                            component.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                        ])
                    }
                }
            }
        }
    }
    
    func addCommunityComponents(_ components: [CommunityComponent]) {
        for component in components {
            if selectedTabIndex == 0 {
                trendingStackView?.addArrangedSubview(component)
            } else if selectedTabIndex == 1 {
                recommendationsStackView?.addArrangedSubview(component)
            } else if selectedTabIndex == 2 {
                myCommunityStackView?.addArrangedSubview(component)
            } else if selectedTabIndex == 3 {
                exploreStackView?.addArrangedSubview(component)
            }
        }
    }

    

    func setupTrending(in view: UIView, numberOfComponents: Int) -> UIStackView {
        trendingSubheading = subHeading(with: "Trending", topAnchorConstant: 70, in: view)
        return setupCommunityComponents(topAnchorConstant: 50, subHeadingLabel: trendingSubheading!, joinNow: false, numberOfComponents: numberOfComponents, in: view)
    }
    
    func setupRecommendations(in view: UIView, numberOfComponents: Int) -> UIStackView {
        recommendationsSubheading = subHeading(with: "Recommendations", topAnchorConstant: 270, in: view)
        return setupCommunityComponents(topAnchorConstant: 250, subHeadingLabel: recommendationsSubheading!, joinNow: false, numberOfComponents: numberOfComponents, in: view)
    }
    
    func setupMyCommunity(in view: UIView, numberOfComponents: Int) -> UIStackView {
        myCommunitySubheading = subHeading(with: "My Community", topAnchorConstant: 470, in: view)
        
        communityStackView1 = setupCommunityComponents(topAnchorConstant: 450, subHeadingLabel: myCommunitySubheading!, joinNow: true, numberOfComponents: numberOfComponents, in: view)
        
        communityStackView2 = setupCommunityComponents(topAnchorConstant: 610, subHeadingLabel: myCommunitySubheading!, joinNow: true, numberOfComponents: numberOfComponents, in: view)
        
        return communityStackView1!
    }
    
    func setupExplore(in view: UIView, numberOfComponents: Int) -> UIStackView {
        exploreSubheading = subHeading(with: "Explore More", topAnchorConstant: 830, in: view)
        exploreStackView1 = setupCommunityComponents(topAnchorConstant: 810, subHeadingLabel: exploreSubheading!, joinNow: false, numberOfComponents: numberOfComponents, in: view)
        exploreStackView2 = setupCommunityComponents(topAnchorConstant: 970, subHeadingLabel: exploreSubheading!, joinNow: false, numberOfComponents: numberOfComponents, in: view)
        
        return exploreStackView1!
        
    }
    
    func setupCommunityComponents(topAnchorConstant: CGFloat, subHeadingLabel: UILabel, joinNow: Bool, numberOfComponents: Int, in view: UIView) -> UIStackView {
        let componentWidth: CGFloat = 200 // Set the fixed width for each component
            let componentSpacing: CGFloat = 8 // Set the spacing between components
            
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchorConstant),
                scrollView.heightAnchor.constraint(equalToConstant: 160) // Set a fixed height for the scroll view
            ])
            
            let communityStackView = UIStackView()
            communityStackView.axis = .horizontal
            communityStackView.spacing = componentSpacing
            communityStackView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(communityStackView)
            

            
            // Calculate the total width of the community components and spacing
            let totalWidth = CGFloat(numberOfComponents) * componentWidth + CGFloat(numberOfComponents - 1) * componentSpacing
            
            // Set the content size of the scroll view
            scrollView.contentSize = CGSize(width: totalWidth, height: 160)
            scrollView.showsHorizontalScrollIndicator = false
            
            // Activate constraints for subheading label
            NSLayoutConstraint.activate([
                subHeadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                subHeadingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchorConstant - 30),
                subHeadingLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        func createCommunityComponent(headingText: String) -> CommunityComponent {
            let communityComponent = CommunityComponent()
            communityComponent.headingLabelText = headingText
            communityComponent.personIconImage = UIImage(named: "person2")
            communityComponent.membersLabelText = "81"
            communityComponent.descriptionLabelText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            communityComponent.isJoined = joinNow
            communityComponent.translatesAutoresizingMaskIntoConstraints = false
            
            // Set width and height constraints
            communityComponent.widthAnchor.constraint(equalToConstant: 200).isActive = true
            communityComponent.heightAnchor.constraint(equalToConstant: 160).isActive = true
            
            // Set compression resistance and content hugging priorities
            communityComponent.setContentCompressionResistancePriority(.required, for: .horizontal)
            communityComponent.setContentHuggingPriority(.required, for: .horizontal)
            communityComponent.setContentCompressionResistancePriority(.required, for: .vertical)
            communityComponent.setContentHuggingPriority(.required, for: .vertical)
            
            communityComponent.delegate = self
            return communityComponent
        }


        
        let communityComponent1 = createCommunityComponent(headingText: "Loyalty Doubts")
        communityStackView.addArrangedSubview(communityComponent1)
        originalComponents.append(communityComponent1)
        
        for _ in 1...3 {
            let communityComponent2 = createCommunityComponent(headingText: "Control ADHD")
            communityStackView.addArrangedSubview(communityComponent2)
            originalComponents.append(communityComponent2)
        }
        
        let communityComponent3 = createCommunityComponent(headingText: "Exam Relief")
        communityStackView.addArrangedSubview(communityComponent3)
        originalComponents.append(communityComponent3)
        
        

        scrollView.contentSize = CGSize(width: totalWidth, height: scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            subHeadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subHeadingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchorConstant - 30),
            subHeadingLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            scrollView.setContentOffset(CGPoint.zero, animated: false)
        }
        
        return communityStackView
    }


    func showContent(for index: Int) {
        switch index {
        case 0:
            // Scroll to the top
            scrollView.setContentOffset(CGPoint.zero, animated: true)
            for case let communityComponent as CommunityComponent in contentView.subviews {
                communityComponent.isHidden = false
            }

        case 1:
            // Scroll to myCommunityStackView
            if let myCommunitySubheading = myCommunitySubheading {
                let yOffset = myCommunitySubheading.frame.origin.y
                scrollView.setContentOffset(CGPoint(x: 0, y: yOffset), animated: true)
            }
            selectedTabIndex = 1

        case 2:
            // Scroll to exploreStackView
            if let exploreSubheading = exploreSubheading {
                let yOffset = exploreSubheading.frame.origin.y
                scrollView.setContentOffset(CGPoint(x: 0, y: yOffset - 10), animated: true)
            }
            selectedTabIndex = 2

        default:
            break
        }

        if let segmentedControl = view.subviews.compactMap({ $0 as? UISegmentedControl }).first {
            segmentedControl.selectedSegmentIndex = selectedTabIndex
        }
    }

    func setupHeader(in view: UIView) {
        // Create a horizontal stack view for the header
        let headerStackView = UIStackView()
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center // Center align the arranged subviews
        let communityImage = UIImageView(image: UIImage(named: "Header"))
        communityImage.contentMode = .scaleAspectFit
        headerStackView.addArrangedSubview(communityImage)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerStackView)

        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
    }


    func setupSearchBar(in view: UIView) {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = UIColor(red: 0.946, green: 0.926, blue: 0.989, alpha: 1)
        searchBar.layer.cornerRadius = 10
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self

        if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
            searchField.background = UIImage()
        }

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            searchBar.heightAnchor.constraint(equalToConstant: 36)
        ])
    }


    func setupTabs(in view: UIView) {
        let segmentedControl = UISegmentedControl(items: ["All", "My Community", "Explore More"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = UIColor(red: 0.18, green: 0.18, blue: 0.357, alpha: 1)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor.black
        ]
        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)

        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)

        // Remove custom labels to avoid overlap
        for i in 0..<segmentedControl.numberOfSegments {
            let segmentView = segmentedControl.subviews[i]
            segmentView.backgroundColor = .white
        }

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32)
        ])
    }


    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        selectedTabIndex = sender.selectedSegmentIndex
        showContent(for: selectedTabIndex)
    }

    func subHeading(with text: String, topAnchorConstant: CGFloat, in view: UIView) -> UILabel {
        let headerLabel = UILabel()
        headerLabel.text = text
        headerLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 10)
        headerLabel.attributedText = NSMutableAttributedString(string: text, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), // Set font size and bold
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue // Set underline
        ])

        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)

        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchorConstant - 50),
            headerLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        return headerLabel
    }
    func joinButtonTapped(in component: CommunityComponent) {
        // Add the component to the stack view
        myCommunityStackView?.addArrangedSubview(component)
        
        // Ensure the width of the component remains constant
        let componentWidth = 210
        component.widthAnchor.constraint(equalToConstant: CGFloat(componentWidth)).isActive = true
        
        // Update the width constraints of the components in the stack view
        for case let subview as CommunityComponent in myCommunityStackView?.arrangedSubviews ?? [] {
            subview.widthAnchor.constraint(equalToConstant: CGFloat(componentWidth)).isActive = true
        }
        
        // Calculate the new width of the stack view
        let newWidth = CGFloat(componentWidth) * CGFloat(myCommunityStackView?.arrangedSubviews.count ?? 0)
        
        // Update the content view's width constraint to accommodate the new width of myCommunityStackView
        contentView.widthAnchor.constraint(equalToConstant: newWidth).isActive = false
        contentView.widthAnchor.constraint(equalToConstant: newWidth).isActive = true
        
        // Inform the stack view's superview (scrollView) to update its layout
        scrollView.layoutIfNeeded()

        if let scrollView = myCommunityStackView?.superview as? UIScrollView {
               scrollView.contentSize.width = newWidth
           }
    }



    


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        
        if yOffset >= myCommunitySubheading?.frame.origin.y ?? 0 && yOffset < exploreSubheading?.frame.origin.y ?? 0 {
            // Scrolled to My Community section
            selectedTabIndex = 1
        } else if yOffset >= exploreSubheading?.frame.origin.y ?? 0 {
            // Scrolled to Explore More section
            selectedTabIndex = 2
        } else {
            // Scrolled to the top or other sections
            selectedTabIndex = 0
        }
        
        // Update the segmented control to reflect the change in selected tab
        if let segmentedControl = view.subviews.compactMap({ $0 as? UISegmentedControl }).first {
            segmentedControl.selectedSegmentIndex = selectedTabIndex
        }
    }
    
    


}

#if DEBUG
import SwiftUI

// Create a SwiftUI preview wrapper for ViewController
@available(iOS 13.0, *)
struct ViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Update the view controller if needed
    }
}

@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview()
            .previewDisplayName("ViewController Preview")
    }
}
#endif

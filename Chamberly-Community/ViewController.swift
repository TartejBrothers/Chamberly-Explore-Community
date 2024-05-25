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
    
    var selectedTabIndex = 0
    var scrollView: UIScrollView!
    var contentView: UIView!
    var numberOfComponents = 5
    var originalComponents: [CommunityComponent] = []
    
//    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader(in: view)
        setupSearchBar(in: view)
        setupTabs(in: view)
        
        // Initialize the scroll view
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
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
        
        // Set content size of scroll view
        let contentWidth = UIScreen.main.bounds.width
        let contentHeight: CGFloat = 1450
        contentView.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
        showContent(for: selectedTabIndex)
//        searchBar.delegate = self
        scrollView.delegate = self
        
    }
    
    func setupTrending(in view: UIView, numberOfComponents: Int) -> UIStackView {
        trendingSubheading = subHeading(with: "Trending", topAnchorConstant: 70, in: view)
        return setupCommunityComponents(topAnchorConstant: 50, subHeadingLabel: trendingSubheading!, joinNow: true, numberOfComponents: numberOfComponents, in: view)
    }
    
    func setupRecommendations(in view: UIView, numberOfComponents: Int) -> UIStackView {
        recommendationsSubheading = subHeading(with: "Recommendations", topAnchorConstant: 270, in: view)
        return setupCommunityComponents(topAnchorConstant: 250, subHeadingLabel: recommendationsSubheading!, joinNow: true, numberOfComponents: numberOfComponents, in: view)
    }
    
    func setupMyCommunity(in view: UIView, numberOfComponents: Int) -> UIStackView {
        myCommunitySubheading = subHeading(with: "My Community", topAnchorConstant: 470, in: view)
        
        communityStackView1 = setupCommunityComponents(topAnchorConstant: 450, subHeadingLabel: myCommunitySubheading!, joinNow: false, numberOfComponents: numberOfComponents, in: view)
        communityStackView2 = setupCommunityComponents(topAnchorConstant: 610, subHeadingLabel: myCommunitySubheading!, joinNow: false, numberOfComponents: numberOfComponents, in: view)
        
        return communityStackView1!
    }
    
    
    func setupExplore(in view: UIView, numberOfComponents: Int) -> UIStackView {
        exploreSubheading = subHeading(with: "Explore More", topAnchorConstant: 830, in: view)
        communityStackView1 = setupCommunityComponents(topAnchorConstant: 810, subHeadingLabel: exploreSubheading!, joinNow: true, numberOfComponents: numberOfComponents, in: view)
        communityStackView2 = setupCommunityComponents(topAnchorConstant: 970, subHeadingLabel: exploreSubheading!, joinNow: true, numberOfComponents: numberOfComponents, in: view)
        
        return communityStackView1!
        
    }
    
    func setupCommunityComponents(topAnchorConstant: CGFloat, subHeadingLabel: UILabel, joinNow: Bool, numberOfComponents: Int, in view: UIView) -> UIStackView {
        let componentWidth = UIScreen.main.bounds.width * 0.4
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchorConstant),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let communityStackView = UIStackView()
        communityStackView.axis = .horizontal
        communityStackView.spacing = 8
        communityStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(communityStackView)
        
        func createCommunityComponent(headingText: String) -> CommunityComponent {
            let communityComponent = CommunityComponent()
            communityComponent.headingLabelText = headingText
            communityComponent.personIconImage = UIImage(named: "person2")
            communityComponent.membersLabelText = "81"
            communityComponent.descriptionLabelText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            communityComponent.isJoined = !joinNow
            communityComponent.translatesAutoresizingMaskIntoConstraints = false
            communityComponent.widthAnchor.constraint(equalToConstant: componentWidth).isActive = true
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
        
        let totalWidth = CGFloat(numberOfComponents) * (componentWidth + 8)
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
        let communityImage = UIImageView(image: UIImage(named: "Header"))
        communityImage.contentMode = .scaleAspectFit
        headerStackView.addArrangedSubview(communityImage)
        let imageView = UIImageView(image: UIImage(named: "Profile"))
        imageView.contentMode = .scaleAspectFit
        headerStackView.addArrangedSubview(imageView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerStackView)

        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -120),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
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
        myCommunityStackView?.addArrangedSubview(component)
        
        // Adjust the width of communityStack1
        let componentWidth = UIScreen.main.bounds.width * 0.4
        let totalWidth = CGFloat(numberOfComponents + 1) * (componentWidth + 8)
        let scrollView = myCommunityStackView?.superview as? UIScrollView
        scrollView?.contentSize = CGSize(width: totalWidth, height: scrollView?.frame.height ?? 0)
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.lowercased(), !searchText.isEmpty else {
            resetComponentVisibility(in: contentView)
            return
        }

        // Temporary array to hold matching components
        var matchingComponents: [CommunityComponent] = []

        // Find matching components
        for component in originalComponents {
            if component.headingLabelText.lowercased().contains(searchText) {
                matchingComponents.append(component)
            }
        }

        // Remove all components from contentView
        contentView.subviews.forEach { $0.removeFromSuperview() }

        // Create a new vertical stack view for search results
        let searchResultsStackView = UIStackView()
        searchResultsStackView.axis = .vertical
        searchResultsStackView.spacing = 0
        searchResultsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchResultsStackView)

        // Add matching components to the search results stack view
        for component in matchingComponents {
            searchResultsStackView.addArrangedSubview(component)
        }

        // Add constraints for the search results stack view
        NSLayoutConstraint.activate([
            searchResultsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            searchResultsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            searchResultsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            searchResultsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        // Scroll the content view to the top
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            resetComponentVisibility(in: contentView)
        }
    }



    func resetComponentVisibility(in view: UIView) {
        // Remove all subviews from the content view
        contentView.subviews.forEach { $0.removeFromSuperview() }

        // Create a new vertical stack view for the original components
        let restoredStackView = UIStackView()
        restoredStackView.axis = .vertical
        restoredStackView.spacing = 0
        restoredStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(restoredStackView)

        // Add the original components back to the restored stack view
        for component in originalComponents {
            restoredStackView.addArrangedSubview(component)
        }

        // Add constraints for the restored stack view
        NSLayoutConstraint.activate([
            restoredStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            restoredStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            restoredStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            restoredStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        // Show subheadings
        trendingSubheading?.isHidden = false
        recommendationsSubheading?.isHidden = false
        myCommunitySubheading?.isHidden = false
        exploreSubheading?.isHidden = false

        scrollView.setContentOffset(CGPoint.zero, animated: true)
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

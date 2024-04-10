import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

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

        trendingStackView = setupTrending(in: contentView)
        recommendationsStackView = setupRecommendations(in: contentView)
        myCommunityStackView = setupMyCommunity(in: contentView)
        exploreStackView = setupExplore(in: contentView)

        // Set content size of scroll view
        let contentWidth = UIScreen.main.bounds.width
        let contentHeight: CGFloat = 1000
        contentView.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
        showContent(for: selectedTabIndex)
    }

    func setupTrending(in view: UIView) -> UIStackView {
        trendingSubheading = subHeading(with: "Trending", topAnchorConstant: 70, in: view)
        return setupCommunityComponents(topAnchorConstant: 50, subHeadingLabel: trendingSubheading!, in: view)
    }

    func setupRecommendations(in view: UIView) -> UIStackView {
        recommendationsSubheading = subHeading(with: "Recommendations", topAnchorConstant: 270, in: view)
        return setupCommunityComponents(topAnchorConstant: 250, subHeadingLabel: recommendationsSubheading!, in: view)
    }
    
    func setupMyCommunity(in view: UIView) -> UIStackView {
        myCommunitySubheading = subHeading(with: "My Community", topAnchorConstant: 470, in: view)
        
        communityStackView1 = setupCommunityComponents(topAnchorConstant: 450, subHeadingLabel: myCommunitySubheading!, in: view)
        communityStackView2 = setupCommunityComponents(topAnchorConstant: 610, subHeadingLabel: myCommunitySubheading!, in: view)
        
        return communityStackView1!
    }


    func setupExplore(in view: UIView) -> UIStackView {
        exploreSubheading = subHeading(with: "Explore More", topAnchorConstant: 830, in: view)
        return setupCommunityComponents(topAnchorConstant: 810, subHeadingLabel: exploreSubheading!, in: view)
    }
    
    func setupCommunityComponents(topAnchorConstant: CGFloat, subHeadingLabel: UILabel, in view: UIView) -> UIStackView {
        let componentWidth = UIScreen.main.bounds.width * 0.4
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Add constraints for the scroll view
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
        
        let communityComponent = CommunityComponent()
        communityComponent.headingLabelText = "Loyalty Doubts"
        communityComponent.personIconImage = UIImage(named: "person2")
        communityComponent.membersLabelText = "81"
        communityComponent.descriptionLabelText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        communityComponent.isJoined = false

        communityComponent.translatesAutoresizingMaskIntoConstraints = false
        communityComponent.widthAnchor.constraint(equalToConstant: componentWidth).isActive = true
        communityStackView.addArrangedSubview(communityComponent)
        for _ in 1...5 {
            let communityComponent = CommunityComponent()
            communityComponent.headingLabelText = "Control ADHD"
            communityComponent.personIconImage = UIImage(named: "person2")
            communityComponent.membersLabelText = "81"
            communityComponent.descriptionLabelText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            communityComponent.isJoined = false

            communityComponent.translatesAutoresizingMaskIntoConstraints = false
            communityComponent.widthAnchor.constraint(equalToConstant: componentWidth).isActive = true
            communityStackView.addArrangedSubview(communityComponent)
        }
        
        let communityComponent2 = CommunityComponent()
        communityComponent2.headingLabelText = "Exam Relief"
        communityComponent2.personIconImage = UIImage(named: "person2")
        communityComponent2.membersLabelText = "81"
        communityComponent2.descriptionLabelText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        communityComponent2.isJoined = false

        communityComponent2.translatesAutoresizingMaskIntoConstraints = false
        communityComponent2.widthAnchor.constraint(equalToConstant: componentWidth).isActive = true
        communityStackView.addArrangedSubview(communityComponent2)
        let totalWidth = CGFloat(7) * (componentWidth + 8)
        scrollView.contentSize = CGSize(width: totalWidth, height: scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        NSLayoutConstraint.activate([
            subHeadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subHeadingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchorConstant - 30), // Adjust this constant based on your layout
            subHeadingLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return communityStackView
    }

    func showContent(for index: Int) {
        switch index {
        case 0:
            // Scroll to the top
            scrollView.setContentOffset(CGPoint.zero, animated: true)
            // Show all content
            for case let communityComponent as CommunityComponent in contentView.subviews {
                communityComponent.isHidden = false
            }

        case 1:
            // Scroll to myCommunityStackView
            if let myCommunitySubheading = myCommunitySubheading {
                let yOffset = myCommunitySubheading.frame.origin.y
                scrollView.setContentOffset(CGPoint(x: 0, y: yOffset), animated: true)
            }
            
        case 2:
            // Scroll to exploreStackView
            if let exploreSubheading = exploreSubheading {
                let yOffset = exploreSubheading.frame.origin.y
                scrollView.setContentOffset(CGPoint(x: 0, y: yOffset), animated: true)
            }
            
        default:
            break
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
        segmentedControl.selectedSegmentIndex = 0 // Set default selection
        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = UIColor(red: 0.18, green: 0.18, blue: 0.357, alpha: 1)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)

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
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchorConstant - 50), // Adjust this constant based on your layout
            headerLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        return headerLabel
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.lowercased() else { return }
        
        var foundMatchingComponent = false
        
        // Recursive function to search for CommunityComponent within subviews
        func findCommunityComponent(in view: UIView) {
            for subview in view.subviews {
                if let stackView = subview as? UIStackView {
                    for arrangedSubview in stackView.arrangedSubviews {
                        if let communityComponent = arrangedSubview as? CommunityComponent {
                            let headingText = communityComponent.headingLabelText.lowercased()
                            let isMatching = headingText.contains(searchText)
                            communityComponent.isHidden = !isMatching
                            
                            // Update the flag if a matching component is found
                            if isMatching {
                                foundMatchingComponent = true
                            }
                        } else {
                            // Recursively search for CommunityComponent within the arranged subview
                            findCommunityComponent(in: arrangedSubview)
                        }
                    }
                } else {
                    // Recursively search for CommunityComponent within the subview
                    findCommunityComponent(in: subview)
                }
            }
        }
        
        // Call the recursive function to search for CommunityComponent within contentView
        findCommunityComponent(in: contentView)
        
        // If no matching component is found, you might want to display a message or handle it accordingly
        if !foundMatchingComponent {
            print("No matching component found.")
            // You can add additional UI updates or actions here
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // If the search text is empty, reset the visibility of all CommunityComponent instances
        if searchText.isEmpty {
            resetComponentVisibility(in: contentView)
        }
    }

    func resetComponentVisibility(in view: UIView) {
        // Recursive function to reset visibility of all CommunityComponent instances
        func resetVisibility(in view: UIView) {
            for subview in view.subviews {
                if let stackView = subview as? UIStackView {
                    for arrangedSubview in stackView.arrangedSubviews {
                        if let communityComponent = arrangedSubview as? CommunityComponent {
                            communityComponent.isHidden = false
                        } else {
                            // Recursively reset visibility within the arranged subview
                            resetVisibility(in: arrangedSubview)
                        }
                    }
                } else {
                    // Recursively reset visibility within the subview
                    resetVisibility(in: subview)
                }
            }
        }
        
        // Call the recursive function to reset visibility within contentView
        resetVisibility(in: contentView)
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

// Provide a preview for ViewController
@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview()
            .previewDisplayName("ViewController Preview")
    }
}
#endif

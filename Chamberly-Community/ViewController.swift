import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupSearchBar()
        setupTabs()
        setupTrending()
        setupCommunityComponents()
    }
    
    func setupTrending() {
        subHeading(with: "Trending")
    }
    
    func setupCommunityComponents() {
        // Create a scroll view to hold all community components
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Add constraints for the scroll view
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor) // Adjust this constraint as needed
        ])
        
        // Create a stack view inside the scroll view to hold the community components horizontally
        let communityStackView = UIStackView()
        communityStackView.axis = .horizontal
        communityStackView.spacing = 8
        communityStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(communityStackView)
        
        // Add constraints for the stack view
        NSLayoutConstraint.activate([
            communityStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            communityStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            communityStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            communityStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor) // Match the height of the scroll view
        ])
        
        // Define the width of each community component
        let componentWidth = UIScreen.main.bounds.width * 0.8
        
        // Add community components to the stack view
        for _ in 1...5 {
            // Create a scroll view for each community component
            let componentScrollView = UIScrollView()
            componentScrollView.translatesAutoresizingMaskIntoConstraints = false
            componentScrollView.backgroundColor = .clear
            componentScrollView.layer.cornerRadius = 10
            communityStackView.addArrangedSubview(componentScrollView)
            
            // Add constraints for the component scroll view
            NSLayoutConstraint.activate([
                componentScrollView.widthAnchor.constraint(equalToConstant: componentWidth),
                componentScrollView.heightAnchor.constraint(equalTo: scrollView.heightAnchor) // Match the height of the scroll view
            ])
            
            // Create a community component inside the component scroll view
            let communityComponent = CommunityComponent()
            communityComponent.translatesAutoresizingMaskIntoConstraints = false
            componentScrollView.addSubview(communityComponent)
            
            // Add constraints for the community component
            NSLayoutConstraint.activate([
                communityComponent.leadingAnchor.constraint(equalTo: componentScrollView.leadingAnchor),
                communityComponent.trailingAnchor.constraint(equalTo: componentScrollView.trailingAnchor),
                communityComponent.topAnchor.constraint(equalTo: componentScrollView.topAnchor),
                communityComponent.bottomAnchor.constraint(equalTo: componentScrollView.bottomAnchor),
                communityComponent.widthAnchor.constraint(equalTo: componentScrollView.widthAnchor)
            ])
        }
        
        // Calculate the content width of the stack view
        let contentWidth = CGFloat(5) * (componentWidth + 8) // 8 is the spacing between components
        
        // Set the content size of the stack view
        communityStackView.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
    }

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabs()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabs()
    }
    
    func setupHeader() {
        // Create a horizontal stack view for the header
        let headerStackView = UIStackView()
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.spacing = 8
        
        let label = UILabel()
        label.text = "Communities"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .left
        
        headerStackView.addArrangedSubview(label)
        let imageView = UIImageView(image: UIImage(named: "pfp"))
        imageView.contentMode = .scaleAspectFit
        headerStackView.addArrangedSubview(imageView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerStackView)
        
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    
    func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = UIColor(red: 0.946, green: 0.926, blue: 0.989, alpha: 1)
        searchBar.layer.cornerRadius = 10
        
        searchBar.backgroundImage = UIImage()
        
        // Set clear background for search field to remove additional lines
        if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
            searchField.background = UIImage()
        }
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        // Add custom search icon on the left side
        let searchIconView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchImageView.tintColor = .black
        searchImageView.contentMode = .scaleAspectFit
        searchIconView.addSubview(searchImageView)
        
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            searchBar.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupTabs() {
        let segmentedControl = UISegmentedControl(items: ["All", "My Community", "Explore More"])
        segmentedControl.selectedSegmentIndex = 0 // Set default selection
        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = UIColor(red: 0.18, green: 0.18, blue: 0.357, alpha: 1)
        
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
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func subHeading(with text: String) {
        let headerLabel = UILabel()
        headerLabel.text = text
        headerLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 10)
        headerLabel.attributedText = NSMutableAttributedString(string: text, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), // Set font size and bold
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue // Set underline
        ])
        
        view.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 190),
            headerLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
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


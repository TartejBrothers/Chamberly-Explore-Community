import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupSearchBar()
        setupTabs()
        subHeading(with: "Trending")
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
        
        // Create a label
        let label = UILabel()
        label.text = "Communities"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .left
        
        // Add label to the header stack view
        headerStackView.addArrangedSubview(label)
        
        // Create an image view
        let imageView = UIImageView(image: UIImage(named: "pfp"))
        
        // Add image view to the header stack view
        headerStackView.addArrangedSubview(imageView)
        
        // Add the header stack view to the view
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerStackView)
        
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        ])
    }
    
    func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = UIColor(red: 0.946, green: 0.926, blue: 0.989, alpha: 1)
        searchBar.layer.cornerRadius = 10
        
        // Remove default border from search bar
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

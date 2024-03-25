import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupSearchBar()
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

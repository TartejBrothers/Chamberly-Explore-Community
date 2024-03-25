import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHorizontalRow()
    }
    
    func setupHorizontalRow() {
        // Create a horizontal stack view
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        let label = UILabel()
        label.text = "Communities"
        label.font = UIFont.systemFont(ofSize: 30) // Set label font size
        label.textAlignment = .left // Align label text to the left
        
        // Add label to the stack view
        stackView.addArrangedSubview(label)
        
        // Create an image view
        let imageView = UIImageView(image: UIImage(named: "pfp"))
        
        // Add image view to the stack view
        stackView.addArrangedSubview(imageView)
        
        // Set constraints for the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20), // Adjust vertical position
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


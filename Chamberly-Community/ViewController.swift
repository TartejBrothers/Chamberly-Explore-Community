import UIKit

class ViewController: UIViewController {
    private lazy var header: UILabel = {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 169.14, height: 37)
        view.text = "Communities"
        
        // Create gradient layer for the text
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 0.478, green: 0.478, blue: 1, alpha: 1).cgColor, // #7A7AFF
            UIColor(red: 0.973, green: 0.287, blue: 0.314, alpha: 0.7).cgColor // rgba(248, 73, 80, 0.70)
        ]
        gradientLayer.locations = [0, 1]
        
        // Apply the gradient mask to the text
        view.layer.mask = gradientLayer
        
        // Set font color to black after applying the gradient mask
        view.textColor = .black
        
        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 169.14).isActive = true
        view.heightAnchor.constraint(equalToConstant: 37).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 20).isActive = true // Adjusted top constraint
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        home()
    }
    
    func home() {
        self.view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 1, alpha: 1)
        self.view.addSubview(header)
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

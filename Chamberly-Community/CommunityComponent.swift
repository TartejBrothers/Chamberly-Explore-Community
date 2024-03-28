import UIKit

class CommunityComponent: UIView {
    // Image view at the top
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "community") // Set image
        return imageView
    }()
    
    // Title label with person icon and number of members
    private let titleLabel: UILabel = {
        let label = UILabel()
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "person2")
        
        attachment.bounds = CGRect(x: 0, y: 0, width: 40, height: 24)
        let attachmentString = NSAttributedString(attachment: attachment)
        let labelText = NSMutableAttributedString(string: " Control ADHD", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        labelText.append(attachmentString)
        labelText.append(NSAttributedString(string: " 81", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])) 
        label.attributedText = labelText
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    // Small text below the title
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit." // Set bottom text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    // Join button
    private let joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Join Now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        // Add subviews
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(joinButton) // Add the button directly
        
        // Set constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        joinButton.translatesAutoresizingMaskIntoConstraints = false // Add this line to set constraints for the button
        
        NSLayoutConstraint.activate([
            // Image view constraints
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 30), // Adjust height as needed
            
            // Join button constraints
            joinButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            joinButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            joinButton.widthAnchor.constraint(equalToConstant: 100),
            joinButton.heightAnchor.constraint(equalToConstant: 50), // Adjust height as needed
            
            // Description label constraints
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: joinButton.leadingAnchor, constant: 0), 
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8) // Adjust bottom anchor
        ])
        
        // Ensure the text wraps when covered by the button
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // Apply styling to the "Join" button
        joinButton.backgroundColor = UIColor(red: 0.48, green: 0.48, blue: 0.67, alpha: 1.0) // #7A7AAA
        joinButton.setTitleColor(.white, for: .normal)
        joinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        joinButton.setTitle("Join Now", for: .normal)
        joinButton.layer.cornerRadius = 5

    }


}

import SwiftUI
// Create a SwiftUI wrapper for CommunityComponent
struct CommunityComponentWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> CommunityComponent {
        return CommunityComponent()
    }

    func updateUIView(_ uiView: CommunityComponent, context: Context) {
        // Update the view if needed
    }
}

// SwiftUI preview
@available(iOS 13.0, *)
struct CommunityComponentPreview: PreviewProvider {
    static var previews: some View {
        CommunityComponentWrapper()

            .previewDisplayName("CommunityComponent Preview")
    }
}

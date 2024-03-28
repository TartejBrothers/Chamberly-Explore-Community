import UIKit

class CommunityComponent: UIView {
    // Image view at the top
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "communitycomponent") // Set image
        return imageView
    }()
    
    // Title label for the text
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let controlADHDLabel: UILabel = {
        let label = UILabel()
        label.text = "Control ADHD"
        label.font = UIFont.italicSystemFont(ofSize: 28)
        return label
    }()
    
    // Image view for the person icon
    private let personIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "person2")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Label for the "81" text
    private let membersLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.69, green: 0.69, blue: 0.792, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 20)
    
        label.text = "81\n"
        label.textAlignment = .left
        return label
    }()
    
    // Small text below the title
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
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
        
        // Add subviews with space in between
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(controlADHDLabel)
        addSubview(personIconImageView)
        addSubview(membersLabel)
        addSubview(descriptionLabel)
        addSubview(joinButton)
        
        // Set constraints for image view
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 190),
            imageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        // Set constraints for title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Set constraints for control ADHD label
        controlADHDLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controlADHDLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            controlADHDLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        // Set constraints for person icon image view
        personIconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personIconImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            personIconImageView.trailingAnchor.constraint(equalTo: membersLabel.leadingAnchor, constant: -8),
            personIconImageView.widthAnchor.constraint(equalToConstant: 40),
            personIconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Set constraints for members label
        membersLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            membersLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            membersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        // Set constraints for join button
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            joinButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            joinButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            joinButton.widthAnchor.constraint(equalToConstant: 100),
            joinButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Set constraints for description label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: joinButton.leadingAnchor, constant: 0),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
        ])
        
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

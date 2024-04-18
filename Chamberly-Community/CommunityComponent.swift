import UIKit
protocol CommunityComponentDelegate: AnyObject {
    func joinButtonTapped(in component: CommunityComponent)
}
class CommunityComponent: UIView {
    // Properties for dynamic content
    var headingLabelText: String = "" {
        didSet {
            headingLabel.text = headingLabelText
        }
    }
    
    var personIconImage: UIImage? {
        didSet {
            personIconImageView.image = personIconImage
        }
    }
    
    var membersLabelText: String = "" {
        didSet {
            membersLabel.text = membersLabelText
        }
    }
    
    var descriptionLabelText: String = "" {
        didSet {
            descriptionLabel.text = descriptionLabelText
        }
    }
    
    var isJoined: Bool = false {
        didSet {
            joinButton.setTitle(isJoined ? "Joined" : "Join Now", for: .normal)
        }
    }
    
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
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        return label
    }()
    
    // Image view for the person icon
    private let personIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let membersLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.69, green: 0.69, blue: 0.792, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    // Small text below the title
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 6)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.numberOfLines = 0
        return label
    }()
    
    
    fileprivate let joinButton: UIButton = {
        let button = UIButton()
               button.backgroundColor = UIColor(red: 0.48, green: 0.48, blue: 1.0, alpha: 1.0)
               button.setTitleColor(.white, for: .normal)
               button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 7)
               button.layer.cornerRadius = 5
               button.addTarget(self, action: #selector(joinButtonTapped(_:)), for: .touchUpInside)
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
            layer.borderWidth = 3
            layer.borderColor = UIColor(red: 0.97, green: 0.97, blue: 1.0, alpha: 1.0).cgColor
            layer.cornerRadius = 10
            clipsToBounds = true
        
        backgroundColor = .white
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(headingLabel)
        addSubview(personIconImageView)
        addSubview(membersLabel)
        addSubview(descriptionLabel)
        addSubview(joinButton)
        
        let padding: CGFloat = 10
            
            // Set constraints for image view
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                imageView.heightAnchor.constraint(equalToConstant: 70),
                imageView.widthAnchor.constraint(equalToConstant: 60)
            ])
            
            // Set constraints for title label
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                titleLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
            
            // Set constraints for control ADHD label
            headingLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                headingLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)
            ])
            
            // Set constraints for person icon image view
            personIconImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                personIconImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                personIconImageView.trailingAnchor.constraint(equalTo: membersLabel.leadingAnchor, constant: 0),
                personIconImageView.widthAnchor.constraint(equalToConstant: 20),
                personIconImageView.heightAnchor.constraint(equalToConstant: 20)
            ])
            
            // Set constraints for members label
            membersLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                membersLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                membersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
            ])
            
            // Set constraints for join button
            joinButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                joinButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
                joinButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                joinButton.widthAnchor.constraint(equalToConstant: 40),
                joinButton.heightAnchor.constraint(equalToConstant: 20)
            ])
            
            // Set constraints for description label
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
                descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                descriptionLabel.trailingAnchor.constraint(equalTo: joinButton.leadingAnchor, constant: -padding),
                descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -padding)
            ])
            
            descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
    
    weak var delegate: CommunityComponentDelegate?

    @objc private func joinButtonTapped(_ sender: UIButton) {
        delegate?.joinButtonTapped(in: self)
        isJoined = !isJoined
    }

}

import SwiftUI
// SwiftUI preview
@available(iOS 13.0, *)
struct CommunityComponentPreview: PreviewProvider {
    static var previews: some View {
        CommunityComponentWrapper()
            .previewDisplayName("CommunityComponent Preview")
    }
}

// Create a SwiftUI wrapper for CommunityComponent
struct CommunityComponentWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> CommunityComponent {
        let view = CommunityComponent()
        view.headingLabelText = "Control ADHD"
        view.personIconImage = UIImage(named: "person2")
        view.membersLabelText = "81"
        view.descriptionLabelText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        view.isJoined = false // Initially not joined
        return view
    }

    func updateUIView(_ uiView: CommunityComponent, context: Context) {
        // Update the view if needed
    }
}

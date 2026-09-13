import UIKit

final class InstructionsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let icon = UIImageView(image: UIImage(systemName: "button.programmable"))
        icon.tintColor = .systemBlue
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 56).isActive = true

        let titleLabel = makeLabel(
            "MultiButton",
            font: .preferredFont(forTextStyle: .largeTitle),
            color: .label
        )
        titleLabel.textAlignment = .center

        let descriptionLabel = makeLabel(
            "This app adds the “Detect iPhone Orientation” action to Shortcuts.",
            font: .preferredFont(forTextStyle: .body),
            color: .secondaryLabel
        )
        descriptionLabel.textAlignment = .center

        let stepsLabel = makeLabel(
            "1. Create a new shortcut.\n2. Add “Detect iPhone Orientation.”\n3. Add conditions for the returned value.\n4. Assign the shortcut to the Action Button.",
            font: .preferredFont(forTextStyle: .body),
            color: .label
        )

        let privacyLabel = makeLabel(
            "The sensor runs for about 0.16 seconds only when the shortcut is invoked. No data is stored or transmitted.",
            font: .preferredFont(forTextStyle: .footnote),
            color: .tertiaryLabel
        )
        privacyLabel.textAlignment = .center

        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Open Shortcuts"
        configuration.cornerStyle = .large
        button.configuration = configuration
        button.addTarget(self, action: #selector(openShortcuts), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [
            icon,
            titleLabel,
            descriptionLabel,
            stepsLabel,
            button,
            privacyLabel
        ])
        stack.axis = .vertical
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -12),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func makeLabel(_ text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }

    @objc private func openShortcuts() {
        guard let url = URL(string: "shortcuts://") else { return }
        UIApplication.shared.open(url)
    }
}

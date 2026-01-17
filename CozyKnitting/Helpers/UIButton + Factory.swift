import UIKit

extension UIButton {
    static func makeButton(title: String, systemImage: String, foregroundColor: UIColor, backgroundColor: UIColor, textSize: CGFloat ) -> UIButton {
        
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString(
            title,
            attributes: .init([
                .font: UIFont(name: "Arial Rounded MT Bold", size: textSize) ?? UIFont.self
            ])
        )
        
        config.image = UIImage(systemName: systemImage)
        config.imagePlacement = .leading
        config.imagePadding = 5
        
        config.baseBackgroundColor = backgroundColor
        config.baseForegroundColor = foregroundColor
        config.cornerStyle = .capsule
        
        return UIButton(configuration: config)
    }
}

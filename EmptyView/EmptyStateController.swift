
import UIKit

protocol EmptyStateController {}

extension EmptyStateController where Self: UIViewController {

	func showEmptyState(image: UIImage, message: String) {
		if let view = self.view.viewWithTag(243) {
			view.removeFromSuperview()
		}

		let emptyView = EmptyView(image: image, message: message)
		self.view.addSubview(emptyView)

		let constraintWidth = NSLayoutConstraint(item: emptyView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 0.75, constant: 0)

		let constraintHeight = NSLayoutConstraint(item: emptyView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.6, constant: 0)

		let centerX = NSLayoutConstraint(item: emptyView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)

		let centerY = NSLayoutConstraint(item: emptyView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0)

		self.view.addConstraint(constraintWidth)
		self.view.addConstraint(constraintHeight)
		self.view.addConstraint(centerX)
		self.view.addConstraint(centerY)
	}
}

private struct EmptyViewConfig {
	var font: UIFont
	var textColor: UIColor

	static let defaultConfig = EmptyViewConfig()

	private init() {
		self.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
		self.textColor = UIColor(red: 158/255, green: 164/255, blue: 170/255, alpha: 1.0)
	}
}

private class EmptyView : UIView {

	private var messageTextView: UITextView?
	private var imageView: UIImageView?

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	init(image: UIImage, message: String, config: EmptyViewConfig = EmptyViewConfig.defaultConfig) {
		super.init(frame: CGRect.zero)

		self.translatesAutoresizingMaskIntoConstraints = false
		self.tag = 243

		let imageView = UIImageView(image: image)
		imageView.contentMode = .ScaleAspectFit
		self.imageView = imageView

		let messageTextView = UITextView()
		messageTextView.text = message
		messageTextView.backgroundColor = UIColor.clearColor()
		messageTextView.textColor = config.textColor
		messageTextView.textAlignment = .Center
		messageTextView.font = config.font
		messageTextView.editable = false
		messageTextView.userInteractionEnabled = false
		self.messageTextView = messageTextView

		self.addSubview(imageView)
		self.addSubview(messageTextView)
	}

	private override func layoutSubviews() {
		super.layoutSubviews()

		guard let messageTextView = self.messageTextView, imageView = self.imageView else { return }

		let width = self.bounds.size.width
		let height = self.bounds.size.height
		let spacing: CGFloat = 20.0

		let messageHeight = height / 2
		let messageY = (height / 2) + (spacing / 2)

		let imageHeight = messageHeight / 2
		let imageY = messageY - spacing - imageHeight

		let imageFrame = CGRect(x: 0, y: imageY, width: width, height: imageHeight)
		imageView.frame = imageFrame

		let messageFrame = CGRect(x: 0, y: messageY, width: width, height: messageHeight)
		messageTextView.frame = messageFrame

	}

}




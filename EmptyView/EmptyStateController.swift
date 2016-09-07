//
//  ViewController.swift
//  EmptyView
//
//  Created by Benni on 06.09.16.
//  Copyright © 2016 Ben Boecker. All rights reserved.
//

import UIKit

protocol EmptyStateController {}

extension EmptyStateController where Self: UIViewController {

	/// Tag value to identify the `EmptyView` in the view controller's view hierarchy.
	var emptyViewTag: Int {
		return 52683
	}

	func showEmptyState(image: UIImage, message: String) {
		if let view = self.view.viewWithTag(self.emptyViewTag) {
			view.removeFromSuperview()
		}

		let emptyView = EmptyView(image: image, message: message)
		emptyView.tag = self.emptyViewTag
		emptyView.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
		emptyView.center = self.view.center

		if let navController = self.navigationController {
			emptyView.center.offset(CGSize(width: 0, height: navController.navigationBar.bounds.height))
			navController.view.addSubview(emptyView)
		} else {
			self.view.addSubview(emptyView)
		}

		if self is UITableViewController {
			(self as? UITableViewController)?.tableView.tableFooterView = UIView()
		}
	}
}

private extension CGPoint {
	mutating func offset(offset: CGSize) {
		self.x += offset.width
		self.y += offset.height
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




//
//  ViewController.swift
//  EmptyView
//
//  Created by Benni on 06.09.16.
//  Copyright © 2016 Ben Boecker. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EmptyStateController {

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.backgroundColor = UIColor(red: 218/255, green: 224/255, blue: 230/255, alpha: 1.0)

		let message = "No data found.\nPlease check the search parameters."

		if let image = UIImage(named: "filter_large") {

			self.showEmptyState(image, message: message)
		}
		

	}




}


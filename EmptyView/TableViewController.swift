//
//  TableViewController.swift
//  EmptyView
//
//  Created by Benni on 07.09.16.
//  Copyright © 2016 Ben Boecker. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, EmptyStateController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let message = "No data found.\nPlease check the search parameters."
		if let image = UIImage(named: "filter_large") {
			self.showEmptyState(image, message: message)
		}
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return UITableViewCell()
	}

}

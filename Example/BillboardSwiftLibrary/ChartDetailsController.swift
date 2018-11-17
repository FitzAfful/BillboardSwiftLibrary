//
//  ViewController.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzafful on 11/15/2018.
//  Copyright (c) 2018 Fitzafful. All rights reserved.
//

import UIKit
import BillboardSwiftLibrary

class ChartDetailsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var entries: [ChartEntry] = []
	@IBOutlet weak var tableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.register(UINib(nibName: "ChartCell", bundle: nil), forCellReuseIdentifier: "ChartCell")
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.tableFooterView = UIView()
    }

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80.0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return entries.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell", for: indexPath) as! ChartCell
		cell.titleTextView.text = entries[indexPath.row].title
		cell.artistTextView.text = entries[indexPath.row].artist
		cell.rankTextView.text = String(entries[indexPath.row].rank)
		return cell
	}
}


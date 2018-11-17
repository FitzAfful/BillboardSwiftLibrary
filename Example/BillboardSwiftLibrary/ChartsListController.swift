//
//  ViewController.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzafful on 11/15/2018.
//  Copyright (c) 2018 Fitzafful. All rights reserved.
//

import UIKit
import BillboardSwiftLibrary
import FTIndicator

class ChartsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var topChartKeys: [ChartType] = [ChartType.hot100, ChartType.billboard200, ChartType.hotLatin, ChartType.hotRapSongs, ChartType.hotRnBSongs,  ChartType.artist100, ChartType.radioSongs, ChartType.digitalSongSales, ChartType.streamingSongs, ChartType.onDemandStreamingSongs, ChartType.topAlbumSales, ChartType.digitalAlbums	, ChartType.independentAlbums, ChartType.social50, ChartType.tastemakerAlbums]
	var topChartValues: [String] = ["Hot 100 Songs", "Billboard 200", "Hot Latin Songs", "Hot Rap Songs", "Hot RnB Songs", "Artists 100", "Radio Songs", "Digital Song Sales", "Streaming Songs", "OnDemand Streaming Songs","Top Album Sales", "Digital Albums", "Independent Albums", "Social 50", "Tastemakers Albums"]
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.tableFooterView = UIView()
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if(section == 0){
			return "Top Charts"
		}
		return "R&B/HipHop Charts"
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 55.0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if(section == 0){
			return topChartKeys.count
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = topChartValues[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		var key: ChartType!
		var title: String
		
		key = topChartKeys[indexPath.row]
		title = topChartValues[indexPath.row]
	
		FTIndicator.showProgress(withMessage: "Loading")
		let manager = BillboardManager()
		manager.getChart(chartType: key) { (entries, error) in
			FTIndicator.dismissProgress()
			if(error != nil){
				FTIndicator.showError(withMessage: error!.localizedDescription)
				return
			}
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let controller = storyboard.instantiateViewController(withIdentifier: "ChartDetailsController") as! ChartDetailsController
			controller.entries = entries!
			controller.title = title
			self.navigationController?.pushViewController(controller, animated: true)
		}
	}
	

}


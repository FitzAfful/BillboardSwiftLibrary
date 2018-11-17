//
//  ViewController.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzafful on 11/15/2018.
//  Copyright (c) 2018 Fitzafful. All rights reserved.
//

import UIKit
import BillboardSwiftLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let manager = BillboardManager()
		manager.getChart(chartType: ChartType.hot100, date: "2018-11-17") { (entries, error) in
			if error != nil{
				print(error!.localizedDescription)
				return
			}
			
			print(entries!) //Array of ChartEntry
		}
		
    }

}


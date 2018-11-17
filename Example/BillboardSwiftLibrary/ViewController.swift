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
		
		
		let parser = ChartParser()
		
		do {
			let html = try String.init(contentsOf: URL(string: "https://www.billboard.com/charts/hot-100/2011-01-01")!)
			let string = try parser.parse(html)
			
			print(string)
		}catch(let error){
			print(error.localizedDescription)
		}
		
    }

}


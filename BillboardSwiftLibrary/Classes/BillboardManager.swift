//
//  BillboardManager.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzgerald Afful on 16/11/2018.
//

import Foundation

public typealias GetSingleChartCompletionHandler = (_ response: Result<ChartData>) -> Void

protocol BillboardManagerProtocol {
	//Date in String, 
	func getChart(date: String, completionHandler: @escaping GetChartCompletionHandler)
}

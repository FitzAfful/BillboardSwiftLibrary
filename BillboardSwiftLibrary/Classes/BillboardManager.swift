//
//  BillboardManager.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzgerald Afful on 16/11/2018.
//

import Foundation

public typealias GetChartCompletionHandler = (_ response: Result<ChartData>) -> Void

enum ChartType: String {
	case hot100 = "hot-100"
}

protocol BillboardManagerProtocol {
	//Date in String,
	func getChart(chartType: ChartType, date: String, completionHandler: @escaping GetChartCompletionHandler)
	
	//Date in String,
	func getChart(chartType: ChartType, day: Int, month: Int, year: Int, completionHandler: @escaping GetChartCompletionHandler)
}

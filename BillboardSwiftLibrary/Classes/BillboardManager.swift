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

class BillboardManager: BillboardManagerProtocol {
	
	/** Get Artist Following
	
	For more info,  https://www.audiomack.com/data-api/docs#artist-following
	
	- Parameters:
	-  parameter: ArtistParameter (slug)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns Array of Audiomack Users who are followed by specified artist
	*/
	func getChart(chartType: ChartType, date: String, completionHandler: @escaping GetChartCompletionHandler) {
		
	}
	
	/** Get Artist Following
	
	For more info,  https://www.audiomack.com/data-api/docs#artist-following
	
	- Parameters:
	-  parameter: ArtistParameter (slug)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns Array of Audiomack Users who are followed by specified artist
	*/
	func getChart(chartType: ChartType, day: Int, month: Int, year: Int, completionHandler: @escaping GetChartCompletionHandler) {
		
	}
	
	
}

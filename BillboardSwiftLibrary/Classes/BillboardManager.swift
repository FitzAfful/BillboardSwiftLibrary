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
	
	//Check if Date is correct and chart can be found for that date.
	func validateDate(year:Int, month:Int, day: Int)->Bool
}

class BillboardManager: BillboardManagerProtocol {
	
	private let apiClient: ApiClient
	private let gateway: ChartGateway
	
	init() {
		apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,completionHandlerQueue: OperationQueue.main)
		gateway = ChartGateway(apiClient: apiClient)
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
	func getChart(chartType: ChartType, date: String, completionHandler: @escaping GetChartCompletionHandler) {
		let year = 0
		let month = 0
		let day = 0
		let bool = validateDate(year: year, month: month, day: day)
		if(!bool){
			completionHandler(.failure(NSError.createDateError()))
		}
		gateway.getChart(parameter: ChartParameter(name: chartType.rawValue, date: "\(year)-\(month)-\(day)")) { (result) in
			completionHandler(result)
		}
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
		let bool = validateDate(year: year, month: month, day: day)
		if(!bool){
			completionHandler(.failure(NSError.createDateError()))
		}
		gateway.getChart(parameter: ChartParameter(name: chartType.rawValue, date: "\(year)-\(month)-\(day)")) { (result) in
			completionHandler(result)
		}
	}
	
	internal func validateDate(year: Int, month: Int, day: Int) -> Bool {
		//Let all validation go here
		return false
	}
}

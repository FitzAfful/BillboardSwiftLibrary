//
//  BillboardManager.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzgerald Afful on 16/11/2018.
//

import Foundation

public typealias GetChartCompletionHandler = (_ entries: [ChartEntry]?, _ error: Error?) -> Void
public typealias GetChartResultCompletionHandler = (_ result: Result<[ChartEntry]>) -> Void

protocol BillboardManagerProtocol {
	func getChart(chartType: ChartType, date: String, completionHandler: @escaping GetChartCompletionHandler)
	
	func getChart(chartType: ChartType, completionHandler: @escaping GetChartCompletionHandler)
	
	func getChart(chartType: ChartType, day: Int, month: Int, year: Int, completionHandler: @escaping GetChartCompletionHandler)
	
	//Check if Date is correct and chart can be found for that date.
	func validateDate(year:Int, month:Int, day: Int)->Bool
}

public class BillboardManager: BillboardManagerProtocol {
	
	private let apiClient: ApiClient
	private let gateway: ChartGateway
	
	public init() {
		apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,completionHandlerQueue: OperationQueue.main)
		gateway = ChartGateway(apiClient: apiClient)
	}
	
	/** Get Chart
	
	Get Chart of particular type for a particular date
	
	- Parameters:
	-  chartType: ChartType (eg ChartType.hot100)
	-  date: In the format YYYY-MM-DD (eg 2018-11-15)
	-  completionHandler: The completion handler to call when the load request is complete.
	`entries` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` contains localizedDescription with message
	
	- Returns: If successful, returns Array of ChartEntries
	*/
	public func getChart(chartType: ChartType, date: String, completionHandler: @escaping GetChartCompletionHandler) {
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		
		if let myDate = dateFormatter.date(from: date) {
			let year = Calendar.current.component(Calendar.Component.year, from: myDate)
			let month = Calendar.current.component(Calendar.Component.month, from: myDate)
			let day = Calendar.current.component(Calendar.Component.day, from: myDate)
			let bool = validateDate(year: year, month: month, day: day)
			if(!bool){
				completionHandler(nil, NSError.createDateError())
				return
			}
			self.getChart(chartType: chartType, day: day, month: month, year: year) { (entries, error) in
				completionHandler(entries, error)
			}
		} else {
			completionHandler(nil, NSError.createDateError())
		}
	}
	
	/** Get Current Chart
	
	Get Chart of particular type for a particular date
	
	- Parameters:
	-  chartType: ChartType (eg ChartType.hot100)
	-  completionHandler: The completion handler to call when the load request is complete.
	`entries` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` contains localizedDescription with message
	
	- Returns: If successful, returns Array of ChartEntries
	*/
	public func getChart(chartType: ChartType, completionHandler: @escaping GetChartCompletionHandler) {
		let myDate = Date()
		let year = Calendar.current.component(Calendar.Component.year, from: myDate)
		let month = Calendar.current.component(Calendar.Component.month, from: myDate)
		let day = Calendar.current.component(Calendar.Component.day, from: myDate)
		
		gateway.getChart(parameter: ChartParameter(name: chartType.rawValue, date: "\(year)-\(month)-\(day)")) { (result) in
			switch(result) {
			case let .success (response):
				completionHandler(response, nil)
			case let .failure (error):
				completionHandler(nil, error)
			}
		}
	}
	
	/** Get Chart
	
	Get Chart of particular type for a particular date
	
	- Parameters:
	-  chartType: ChartType (eg ChartType.hot100)
	-  day: day of chart (20)
	-  month: month of chart (11)
	-  year: year of chart (2018)
	-  completionHandler: The completion handler to call when the load request is complete.
	`entries` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` contains localizedDescription with message
	
	- Returns: If successful, returns Array of ChartEntries
	*/
	public func getChart(chartType: ChartType, day: Int, month: Int, year: Int, completionHandler: @escaping GetChartCompletionHandler) {
		let bool = validateDate(year: year, month: month, day: day)
		if(!bool){
			completionHandler(nil, NSError.createDateError())
			return
		}
		gateway.getChart(parameter: ChartParameter(name: chartType.rawValue, date: "\(year)-\(month)-\(day)")) { (result) in
			switch(result) {
			case let .success (response):
				completionHandler(response, nil)
			case let .failure (error):
				completionHandler(nil, error)
			}
		}
	}
	
	internal func validateDate(year: Int, month: Int, day: Int) -> Bool {
		
		if(month > 12){
			return false
		}
		
		if(day > 31){
			return false
		}
		
		if((month == 4) || (month == 6) || (month == 9) || (month == 11)){
			if(day > 30){
				return false
			}
		}
		
		if (year % 4 == 0) {
			if((month == 2) && (day > 29)){
				return false
			}
		} else {
			if((month == 2) && (day > 28)){
				return false
			}
		}
		
		let date = Date()
		let calendar = Calendar.current
		
		var dateComponents: DateComponents? = calendar.dateComponents([.hour, .minute, .second], from: Date())
		
		dateComponents?.day = day
		dateComponents?.month = month
		dateComponents?.year = year
		
		if let enquiredDate: Date = calendar.date(from: dateComponents!){
			if(enquiredDate > date){
				return false
			}
		}else{
			return false
		}
		
		return true
	}
}


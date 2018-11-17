//
//  ChartRequests.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzgerald Afful on 16/11/2018.
//

import Foundation


let BASE_URL = "http://www.billboard.com/charts/"

//css selector constants
public let _DATE_ELEMENT_SELECTOR = "button.chart-detail-header__date-selector-button"
public let _PREVIOUS_DATE_SELECTOR = "span.fa-chevron-left"
public let _NEXT_DATE_SELECTOR = "span.fa-chevron-right"
public let _TOP_TITLE_SELECTOR = "div.chart-number-one__title"
public let _TOP_ARTIST_SELECTOR = "div.chart-number-one__artist"
public let _TOP_LAST_POS_SELECTOR = "div.chart-number-one__last-week"
public let _TOP_WEEKS_SELECTOR = "div.chart-number-one__weeks-on-chart"
public let _ENTRY_LIST_SELECTOR = "div.chart-list-item"
public let _ENTRY_TITLE_ATTR = "data-title"
public let _ENTRY_ARTIST_ATTR = "data-artist"
public let _ENTRY_RANK_ATTR = "data-rank"

//constants for the getPositionRowValue helper function
public let _ROW_SELECTOR_FORMAT = "div.chart-list-item__%s"
public let _PEAK_POS_FORMAT = "weeks-at-one"
public let _LAST_POS_FORMAT = "last-week"
public let _WEEKS_ON_CHART_FORMAT = "weeks-on-chart"

public struct ChartParameter {
	public var name: String
	public var date: String
	
	public init(name: String, date: String){
		self.name = name
		self.date = date
	}
}

struct ChartRequest: ApiRequest {
	let parameter: ChartParameter
	
	var urlRequest: URLRequest {
		let url: URL! = URL(string: BASE_URL + parameter.name + "/" + parameter.date)
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		
		return request
	}
}





public protocol ApiRequest {
	var urlRequest: URLRequest { get }
}

public protocol ApiClient {
	func execute<T>(request: ApiRequest, completionHandler: @escaping (_ result: Result<ApiResponse<T>>) -> Void)
	func execute(request: ApiRequest, completionHandler: @escaping (_ result: Result<String>) -> Void)
}

public protocol URLSessionProtocol {
	func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

public class ApiClientImplementation: ApiClient {
	public let urlSession: URLSessionProtocol
	
	public init(urlSessionConfiguration: URLSessionConfiguration, completionHandlerQueue: OperationQueue) {
		urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
	}
	
	// This should be used mainly for testing purposes
	public init(urlSession: URLSessionProtocol) {
		self.urlSession = urlSession
	}
	
	// MARK: - ApiClient
	
	public func execute<T>(request: ApiRequest, completionHandler: @escaping (Result<ApiResponse<T>>) -> Void) {
		let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
			guard let httpUrlResponse = response as? HTTPURLResponse else {
				completionHandler(.failure(NetworkRequestError(error: error)))
				return
			}
			
			let successRange = 200...299
			if successRange.contains(httpUrlResponse.statusCode) {
				do {
					let response = try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
					completionHandler(.success(response))
				} catch {
					completionHandler(.failure(error))
				}
			} else {
				completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
			}
		}
		dataTask.resume()
	}
	
	public func execute(request: ApiRequest, completionHandler: @escaping (Result<String>) -> Void) {
		let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
			guard let httpUrlResponse = response as? HTTPURLResponse else {
				completionHandler(.failure(NetworkRequestError(error: error)))
				return
			}
			
			let successRange = 200...299
			if successRange.contains(httpUrlResponse.statusCode) {
				if let response:String = String(data: data!, encoding: .utf8) {
					completionHandler(.success(response))
				}else {
					completionHandler(.failure(error!))
				}
			} else {
				completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
			}
		}
		dataTask.resume()
	}
}


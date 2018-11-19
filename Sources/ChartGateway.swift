//
//  ApiResponse.swift
//  Aftown
//
//  Created by Cosmin Stirbu on 2/25/17.
//  MIT License

import Foundation




public class ChartGateway {
	public func getChart(parameter: ChartParameter, completionHandler: @escaping GetChartResultCompletionHandler) {
		let apiRequest = ChartRequest(parameter: parameter)
		apiClient.execute(request: apiRequest) { (result: Result<String>) in
			switch result {
			case let .success(response):
				if let entries = try? ChartParser().parse(response){
					completionHandler(.success(entries))
					return
				}
				completionHandler(.failure(NSError.createError("Failed to get Billboard Chart. Please try later")))
			case let .failure(error):
				completionHandler(.failure(error))
			}
		}
	}
	
	public let apiClient: ApiClient
	
	public init(apiClient: ApiClient) {
		self.apiClient = apiClient
	}
	
}




// All entities that model the API responses can implement this so we can handle all responses in a generic way
public protocol InitializableWithData {
	init(data: Data?) throws
}

// Optionally, if you use JSON you can implement InitializableWithJson protocol
protocol InitializableWithJson {
	init(json: [String: Any]) throws
}

// Can be thrown when we can't even reach the API
struct NetworkRequestError: Error {
	let error: Error?
	
	var localizedDescription: String {
		return "Network request error. Please try again later"
	}
}

// Can be thrown when we reach the API but the it returns a 4xx or a 5xx
struct ApiError: Error {
	let data: Data?
	let httpUrlResponse: HTTPURLResponse
}

// Can be thrown by InitializableWithData.init(data: Data?) implementations when parsing the data
struct ApiParseError: Error {
	static let code = 999
	
	let error: Error
	let httpUrlResponse: HTTPURLResponse
	let data: Data?
	
	var localizedDescription: String {
		return error.localizedDescription
	}
}

// This wraps a successful API response and it includes the generic data as well
// The reason why we need this wrapper is that we want to pass to the client the status code and the raw response as well
public struct ApiResponse<T: InitializableWithData> {
	let entity: T
	let httpUrlResponse: HTTPURLResponse
	let data: Data?
	
	public init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
		do {
			self.entity = try T(data: data)
			self.httpUrlResponse = httpUrlResponse
			self.data = data
		} catch {
			throw ApiParseError(error: error, httpUrlResponse: httpUrlResponse, data: data)
		}
	}
}

// Some endpoints might return a 204 No Content
// We can't have Void implement InitializableWithData so we've created a "Void" response
struct VoidResponse: InitializableWithData {
	init(data: Data?) throws {
		
	}
}

extension Array: InitializableWithData {
	public init(data: Data?) throws {
		if(!(data != nil)){
			throw NSError.createParseError()
		}
		guard let data1 = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data1),
			let jsonDic = jsonObject as? NSDictionary,
			let jsonArray = jsonDic.value(forKey: "data") as? [[String: Any]] else {
				
				guard let data = data,
					let jsonObject = try? JSONSerialization.jsonObject(with: data),
					let jsonArray = jsonObject as? [[String: Any]] else{
						
						throw NSError.createParseError()
						
				}
				
				guard let element = Element.self as? InitializableWithJson.Type else {
					throw NSError.createParseError()
				}
				
				self = try jsonArray.map(
					{
						return try element.init(json: $0) as! Element
					}
				)
				return
		}
		
		guard let element = Element.self as? InitializableWithJson.Type else {
			throw NSError.createParseError()
		}
		
		self = try jsonArray.map(
			{
				return try element.init(json: $0) as! Element
			}
		)
	}
}

public extension NSError {
	static func createParseError() -> NSError {
		return NSError(domain: "BillboardSwiftLibrary",
					   code: ApiParseError.code,
					   userInfo: [NSLocalizedDescriptionKey: "A parsing error occured"])
	}
	
	static func createDateError() -> NSError {
		return NSError(domain: "BillboardSwiftLibrary",
					   code: 001,
					   userInfo: [NSLocalizedDescriptionKey: "Date entered is invalid. There is no chart for this date."])
	}
	
	static func createError(_ message: String) -> NSError {
		return NSError(domain: "BillboardSwiftLibrary",
					   code: 001,
					   userInfo: [NSLocalizedDescriptionKey: message])
	}
}


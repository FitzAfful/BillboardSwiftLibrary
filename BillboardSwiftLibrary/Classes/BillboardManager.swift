//
//  BillboardManager.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzgerald Afful on 16/11/2018.
//

import Foundation

public typealias GetChartCompletionHandler = (_ entries: [ChartEntry]?, _ error: Error?) -> Void
public typealias GetChartResultCompletionHandler = (_ result: Result<[ChartEntry]>) -> Void

public enum ChartType: String {
	case hot100 = "hot-100"
	case hotLatin = "latin-songs"
	case billboard200 = "billboard-200"
	case artist100 = "artist-100"
	case radioSongs = "radio-songs"
	case digitalSongSales = "digital-song-sales"
	case streamingSongs = "streaming-songs"
	case songsOfTheSummer = "summer-songs"
	case onDemandStreamingSongs = "on-demand-songs"
	case topAlbumSales = "top-album-sales"
	case digitalAlbums = "digital-albums"
	case independentAlbums = "independent-albums"
	case social50 = "social-50"
	case tastemakerAlbums = "tastemaker-albums"
	
	//RnB-HipHop
	case hotRnB_HipHopSongs = "r-b-hip-hop-songs"
	case hotRnBSongs = "r-and-b-songs"
	case hotRapSongs = "rap-song"
	case hotRnbHipHopAirplay = "hot-r-and-b-hip-hop-airplay"
	case rnbHipHopDigitalSongSales = "r-and-b-hip-hop-digital-song-sales"
	case rnbHipHopStreamingSongs = "r-and-b-hip-hop-streaming-songs"
	case rnbStreamingSongs = "r-and-b-streaming-songs"
	case rapStreamingSongs = "rap-streaming-songs"
	case rnbHipHopAlbums = "r-b-hip-hop-albums"
	case rnbAlbums = "r-and-b-albums"
	case rapAlbums = "rap-albums"
	case hotAdultRnbAirplay = "hot-adult-r-and-b-airplay"
	case rhythmic40 = "rhythmic-40"
	
	//Christian-Gospel
	case christianSongs = "christian-songs"
	case christianAirplay = "christian-airplay"
	case christianDigitalSongSales = "christian-digital-song-sales"
	case christianStreamingSongs = "christian-streaming-songs"
	case christianAlbums = "christian-albums"
	case gospelSongs = "gospel-songs"
	case gospelAirplay = "gospel-airplay"
	case gospelDigitalSongSales = "gospel-digital-song-sales"
	case gospelStreamingSongs = "gospel-streaming-songs"
	case gospelAlbums = "gospel-albums"
	
	//Breaking And Entering
	case emergingArtists = "aaf"
	case heatSeekersAlbums = "heatseekers-albums"
	
	//Greatest of all time
	case greatestBillboard200Albums = "greatest-billboard-200-albums"
	case greatestBillboard200Artists = "greatest-billboard-200-artists"
	case greatestHot100Singles = "greatest-hot-100-singles"
	case greatestHot100Artists = "greatest-hot-100-artists"
	case greatestHot100ByWomen = "greatest-hot-100-songs-by-women"
	case greatestHot100WomenArtists = "greatest-hot-100-women-artists"
	case greatestBillboard200AlbumsByWomen = "greatest-billboard-200-albums-by-women"
	case greatestBillboard200WomenArtists = "greatest-billboard-200-women-artists"
	case greatestPopSongsOfAllTime = "greatest-of-all-time-pop-songs"
	case greatestPopSongsArtistsOfAllTime = "greatest-of-all-time-pop-songs-artists"
	case greatestAdultPopSongs = "greatest-adult-pop-songs"
	case greatestAdultPopArtists = "greatest-adult-pop-artists"
	case greatestCountrySongs = "greatest-country-songs"
	case greatestCountryAlbums = "greatest-country-albums"
	case greatestCountryArtists = "greatest-country-artists"
	case greatestHotLatinSongs = "greatest-hot-latin-songs"
	case greatestHotLatinSongsArtists = "greatest-hot-latin-songs-artists"
	case greatestTopDanceClubArtists = "greatest-top-dance-club-artists"
	case greatestRnbHipHopSongs = "greatest-r-b-hip-hop-songs"
	case greatestRnbHipHopAlbums = "greatest-r-b-hip-hop-albums"
	case greatestRnbHipHopArtists = "greatest-r-b-hip-hop-artists"
	case greatestAlternativeSongs = "greatest-alternative-songs"
	case greatestAlternativeArtists = "greatest-alternative-artists"
	
	//Country
	case countrySongs = "country-songs"
	case countryAirplay = "country-airplay"
	case countryDigitalSongSales = "country-digital-song-sales"
	case countryStreamingSongs = "country-streaming-songs"
	case countryAlbums = "country-albums"
	case bluegrassAlbums = "bluegrass-albums"
	case americanaFolkAlbums = "americana-folk-albums"
	
	//Dance-Electronic
	case hotDanceElectronicSongs = "dance-electronic-songs"
	case danceElectronicDigitalSongSales = "dance-electronic-digital-song-sales"
	case danceElectronicStreamingSongs = "dance-electronic-streaming-songs"
	case danceClubSongs = "dance-club-play-songs"
	case danceMixShowAirplay = "hot-dance-airplay"
	case topDanceElectronicAlbums = "dance-electronic-albums"
	
	//Holiday
	case holiday100 = "hot-holiday-songs"
	case holidayDigitalSongSales = "holiday-season-digital-song-sales"
	case holidayAlbums = "holiday-albums"
	case holidayStreamingSongs = "holiday-streaming-songs"
	case holidayAirplay = "holiday-songs"
}

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
	func getChart(chartType: ChartType, completionHandler: @escaping GetChartCompletionHandler) {
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


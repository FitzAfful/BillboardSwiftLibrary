//
//  ChartParser.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzgerald Afful on 17/11/2018.
//

import Foundation
import SwiftSoup

public class ChartParser {
	
	internal var document: Document = Document.init("")
	
	public init() {
		
	}
	
	public func parse(_ string: String) throws -> [ChartEntry]{
		var entries: [ChartEntry] = []
		do {
			document = try SwiftSoup.parse(string)
		} catch {
			let message = "Failed to parse Billboard Chart. Please try later"
			throw NSError.createError(message)
		}
		
		
		do {
			var topArtist = ""
			if let topArtistElement = try? document.select(_TOP_ARTIST_SELECTOR) {
				topArtist = try topArtistElement.text()
			}
			
			let topRank = 1
			let topTitle = try document.select(_TOP_TITLE_SELECTOR).text()
			
			var topIsNew = false
			var topPeakPos: Int = 0
			var topLastPos: Int = 0
			var topWeeks: Int = 0
			
			topPeakPos = 1
				
			//int(soup.select_one(_TOP_LAST_POS_SELECTOR).string.strip())
			if let text = try? document.select(_TOP_LAST_POS_SELECTOR).text(){
				if((text != "") && (text != "--")){
					topLastPos = Int(text)!
				}
			}else{
				topLastPos = 1
			}
			if let topWeeksElement = try? document.select(_TOP_WEEKS_SELECTOR).text() {
				if((topWeeksElement != "") && (topWeeksElement != "--")){
					topWeeks = Int(topWeeksElement)!
				}
			}else{
				topWeeks = 0
			}
				
			if(topWeeks == 0){
				topIsNew = true
			}
			
			let topEntry = ChartEntry(title: topTitle, artist: topArtist, peakPos: topPeakPos, lastPos: topLastPos, weeks: topWeeks, rank: topRank, isNew: topIsNew)
			entries.append(topEntry)
			
		} catch  {
			let message = "Failed to parse top track title"
			throw NSError.createError(message)
		}
		
		for entrySoup in try document.select(_ENTRY_LIST_SELECTOR) {
			let title = try entrySoup.attr(_ENTRY_TITLE_ATTR)
			let artist = try entrySoup.attr(_ENTRY_ARTIST_ATTR)
			
			var rank = 0
			if let rankText =  try? entrySoup.attr(_ENTRY_RANK_ATTR){
				rank = Int (rankText)!
			}else{
				throw NSError.createError("Failed to parse Billboard Chart. Please try later")
			}
			var isNew = false
			var peakPos: Int = 0
			var lastPos: Int = 0
			var weeks: Int = 0
			
			peakPos = try self.getPositionRowValue(rowName: _PEAK_POS_FORMAT, entrySoup: entrySoup)
			if(peakPos == 0){
				peakPos = rank
			}
			lastPos = try self.getPositionRowValue(rowName: _LAST_POS_FORMAT, entrySoup: entrySoup)
			weeks = try self.getPositionRowValue(rowName: _WEEKS_ON_CHART_FORMAT, entrySoup: entrySoup)
			if(weeks == 0){
				isNew = true
			}
			
			let entry = ChartEntry(title: title, artist: artist, peakPos: peakPos, lastPos: lastPos, weeks: weeks, rank: rank, isNew: isNew)
			entries.append(entry)
		}
		
		return entries
	}
	
	func getPositionRowValue(rowName: String, entrySoup: Element) throws -> Int{
		let selector = "div.chart-list-item__\(rowName)"
		do {
			let selected = try entrySoup.select(selector)
			if(try selected.text() == "-"){
				return 0
			} else if(try selected.text().isEmpty){
				return 0
			}else{
				return Int(try selected.text())!
			}
		}catch {
			return 0
		}
	}
}

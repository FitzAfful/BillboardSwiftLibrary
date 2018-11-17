//
//  ChartEntry.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzgerald Afful on 08/11/2018.
//

import Foundation

/// Represents a particular Billboard chart for a particular date.
public struct ChartData {
	
	///name: The chart name, as a string.
	public var name: String
	
	///date: The date of the chart.
	public var date: String
	
	///previousDate: The date of the previous chart, as a string in YYYY-MM-DD format, or None if this information was not available.
	public var previousDate: String?
	
	///entries: A list of ChartEntry objects, ordered by position on the chart (highest first).
	public var entries: [ChartEntry] = []
	
	init(name:String, date: String, previousDate: String?, entries: [ChartEntry]) {
		self.name = name
		self.date = date
		self.previousDate = previousDate
		self.entries = entries
	}
	
	
}

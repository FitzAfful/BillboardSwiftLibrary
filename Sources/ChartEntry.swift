//
//  ChartEntry.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzgerald Afful on 08/11/2018.
//

import Foundation

/// Represents an entry (typically a single track) on a chart.
public struct ChartEntry {
	
	///title: The title of the track.
	public var title: String
	
	///artist: The name of the track artist, as formatted on Billboard.com. If there are multiple artists and/or featured artists, they will	be included in this string.
	public var artist: String
	
	///peakPos: The track's peak position on the chart at any point in time, including future dates, as an int (or None if the chart does not include this information).
	public var peakPos: Int
	
	///lastPos: The track's position on the previous week's chart, as an int. (or None if the chart does not include this information). This value is 0 if the track was not on the previous week's chart.
	public var lastPos: Int
	
	///weeks: The number of weeks the track has been or was on the chart, including future dates (up until the present time).
	public var weeks: Int
	
	///rank: The track's position on the chart, as an int.
	public var rank: Int
	
	///isNew: Whether the track is new to the chart, as a boolean.
	public var isNew: Bool

	public init(title:String, artist: String, peakPos: Int, lastPos: Int, weeks: Int, rank: Int, isNew: Bool) {
		self.title = title
		self.lastPos = lastPos
		self.artist = artist
		self.peakPos = peakPos
		self.weeks = weeks
		self.rank = rank
		self.isNew = isNew
	}
	
	
}

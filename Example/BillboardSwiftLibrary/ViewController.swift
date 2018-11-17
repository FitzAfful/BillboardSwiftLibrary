//
//  ViewController.swift
//  BillboardSwiftLibrary
//
//  Created by Fitzafful on 11/15/2018.
//  Copyright (c) 2018 Fitzafful. All rights reserved.
//

import UIKit
import BillboardSwiftLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		/*
			artist - check
			billboard - check
			hot 100 - check
			hot latin - check
			digital albums - check
			digital song sales - check
			independentAlbums - check
			ondemandstreamingsongs - check
			radioSongs - check
			social50 - check
			songsOfTheSummer - didnt work
			streamingSongs - check
			tastemakerAlbums - check
			topAlbumSales - check
		
			hotRnB_HipHopSongs = check
		 	hotRnBSongs = check
		 	hotRapSongs = check
		 	hotRnbHipHopAirplay = check
		 	rnbHipHopDigitalSongSales = check
		 	rnbHipHopStreamingSongs = check
		 	rnbStreamingSongs = check
		 	rapStreamingSongs = check
		 	rnbHipHopAlbums = check
		 	rnbAlbums = check
		 	rapAlbums = check
		 	hotAdultRnbAirplay = check
		 	rhythmic40 = check
		
			christian-songs =
			christian-airplay =
			christian-digital-song-sales =
			christian-streaming-songs =
			christian-albums =
			gospel-songs =
			gospel-airplay =
			gospel-digital-song-sales =
			gospel-streaming-songs =
			gospel-albums = 
		*/
		
		let manager = BillboardManager()
		manager.getChart(chartType: ChartType.rhythmic40, date: "2018-11-17") { (entries, error) in
			if error != nil{
				print(error!.localizedDescription)
				return
			}
			
			print(entries!) //Array of ChartEntry
		}
		
    }

}


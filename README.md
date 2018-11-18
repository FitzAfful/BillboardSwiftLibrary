# BillboardSwiftLibrary

[![CI Status](https://img.shields.io/travis/Fitzafful/BillboardSwiftLibrary.svg?style=flat)](https://travis-ci.org/Fitzafful/BillboardSwiftLibrary)
[![Version](https://img.shields.io/cocoapods/v/BillboardSwiftLibrary.svg?style=flat)](https://cocoapods.org/pods/BillboardSwiftLibrary)
[![License](https://img.shields.io/cocoapods/l/BillboardSwiftLibrary.svg?style=flat)](https://cocoapods.org/pods/BillboardSwiftLibrary)
[![Platform](https://img.shields.io/cocoapods/p/BillboardSwiftLibrary.svg?style=flat)](https://cocoapods.org/pods/BillboardSwiftLibrary)

## Basic Usage
To download a Billboard chart, we use the BillboardManager constructor.

Let's fetch the current Hot 100 chart and for a particular date.

Dont forget to set Allow Arbitrary Loads under App Transport Security Settings in your info.plist to YES

```swift
import BillboardSwiftLibrary

let manager = BillboardManager()
manager.getChart(chartType: ChartType.hot100) { (entries, error) in
	if error != nil{
		print(error!.localizedDescription)
		return
	}

	print(entries!) //Array of ChartEntry
}



//FOR A PARTICULAR DATE (always remember date is in the form YYYY-MM-DD)
manager.getChart(chartType: ChartType.hot100, date: "2018-11-18") { (entries, error) in
	if error != nil{
		print(error!.localizedDescription)
		return
	}

	print(entries!) //Array of ChartEntry
}



//FOR A PARTICULAR DATE (with individual date components)
manager.getChart(chartType: ChartType.hot100, day: 18, month: 11, year: 2018) { (entries, error) in
	if error != nil{
		print(error!.localizedDescription)
		return
	}

	print(entries!) //Array of ChartEntry
}

```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 9.0+ / OSX 10.10+
- Swift 4.0+

## Installation

BillboardSwiftLibrary is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BillboardSwiftLibrary'
```

### Chart entry attributes

A chart entry (typically a single track) is of type `ChartEntry`. A `ChartEntry` instance has the following attributes:

* `title` &ndash; The title of the track.
* `artist` &ndash; The name of the artist, as formatted on Billboard.com.
* `peakPos` &ndash; The track's peak position on the chart at any point in time, including future dates, as an int (or `None` if the chart does not include this information).
* `lastPos` &ndash; The track's position on the previous week's chart, as an int (or `None` if the chart does not include this information). This value is 0 if the track was not on the previous week's chart.
* `weeks` &ndash; The number of weeks the track has been or was on the chart, including future dates (up until the present time).
* `rank` &ndash; The track's current position on the chart.
* `isNew` &ndash; Whether the track is new to the chart.

## Contributing

Pull requests are welcome! 

Think you found a bug? Create an issue [here](https://github.com/fitzafful/BillboardSwiftLibrary/issues).

Based on [Billboard.py](https://github.com/guoguo12/billboard-charts) by Allen Guo

## Author

Fitzafful, fitzafful@gmail.com

## License

BillboardSwiftLibrary is available under the MIT license. See the LICENSE file for more info.

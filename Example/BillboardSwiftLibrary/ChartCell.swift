//
//  ChartCell.swift
//  BillboardSwiftLibrary_Example
//
//  Created by Fitzgerald Afful on 17/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ChartCell: UITableViewCell {

	@IBOutlet weak var rankTextView: UILabel!
	@IBOutlet weak var titleTextView: UILabel!
	@IBOutlet weak var artistTextView: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

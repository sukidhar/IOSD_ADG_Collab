//
//  CityWeatherCell.swift
//  IOSD-ADG_Collab
//
//  Created by Sukidhar Darisi on 4/10/20.
//

import UIKit

class CityWeatherCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temparatureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

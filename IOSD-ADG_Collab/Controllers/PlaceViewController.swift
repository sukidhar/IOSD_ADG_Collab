//
//  PlaceViewController.swift
//  IOSD-ADG_Collab
//
//  Created by Sukidhar Darisi on 4/10/20.
//

import UIKit

class PlaceViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temparatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    var weather : WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let weather = weather{
            cityNameLabel.text = weather.cityName
            temparatureLabel.text = weather.temparatureString
            weatherImage.image = UIImage(systemName: weather.conditonName, withConfiguration: .none)
        }
    }

    
}

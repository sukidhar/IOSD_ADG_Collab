//
//  WeatherData.swift
//  IOSD-ADG_Collab
//
//  Created by Sukidhar Darisi on 4/10/20.
//

import Foundation

struct WeatherData : Codable{
    let name : String
    let main : Main
    let weather : [Weather]
}
struct Main : Codable {
    let temp :  Double
}
struct Weather : Codable {
    let id : Int
}


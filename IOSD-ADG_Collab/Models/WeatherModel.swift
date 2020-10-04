//
//  WeatherModel.swift
//  IOSD-ADG_Collab
//
//  Created by Sukidhar Darisi on 4/10/20.
//

import Foundation

struct WeatherModel{
    let conditonId  : Int
    let cityName : String
    let temparature : Double
    
    var temparatureString : String{
        return(String(format : "%.1f", temparature))
    }
    var conditonName : String{
          switch conditonId {
          case 200...232:
              return "cloud.bolt"
          case 300...321:
              return "cloud.drizzle"
          case 500...531:
              return "cloud.rain"
          case 600...622:
              return "cloud.snow"
          case 701...781:
              return "cloud.fog"
          case 800:
              return "sun.max"
          case 801...804:
              return "cloud.bolt"
          default:
              return "cloud"
          }
      }
}

//
//  WeatherManager.swift
//  IOSD-ADG_Collab
//
//  Created by Sukidhar Darisi on 4/10/20.
//

import Foundation

struct WeatherManager {
    let apiKey = "2d34f12e327ae9844b9c75da791f1dc1"
    
    let WeatherURL = "https://api.openweathermap.org/data/2.5/weather?appid="
    
    func convertNameIntoLinkFor(_ cityname : String)->String{
        let convertedName = cityname.replacingOccurrences(of: " ", with: "%20")
        return convertedName
    }
    
    func fetchWeather(cityname : String, completion : @escaping (_ weather : WeatherModel?, _ error : Error?)->Void)  {
        let urlString = "\(WeatherURL)\(apiKey)&q=\(convertNameIntoLinkFor(cityname))&units=metric"
        performRequest(with: urlString, completion : completion)
    }
    
    func performRequest(with urlString : String,completion : @escaping (_ weather : WeatherModel?, _ error : Error?)->Void) {
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil
                {
                    completion(nil,error)
                    return
                }
                if let safeData = data
                {
                    self.parseJSON(weatherData: safeData) { (weather, error) in
                        if let error = error{
                            completion(nil,error)
                        }
                        if let weather = weather{
                            completion(weather,nil)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(weatherData : Data,completion : @escaping (_ weather : WeatherModel?, _ error : Error?)->Void){
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            let weather = WeatherModel(conditonId: id, cityName: name, temparature: temp)
            completion(weather,nil)
        }
        catch{
            completion(nil, error)
        }
    }
  

}

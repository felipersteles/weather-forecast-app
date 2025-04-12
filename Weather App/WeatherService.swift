//
//  WeatherService.swift
//  Weather App
//
//  Created by Felipe Teles on 12/04/25.
//

import Foundation

struct City{
    let lat: String;
    let long: String;
    let name: String;
}

class WeatherService{
    private let baseURL = "https://api.openweathermap.org/data/3.0/onecall";
    private let apiKey = "_";
    private let session = URLSession.shared;
    
    func fetchData(city: City, _ completion: @escaping (ForecastResponse?) -> Void){
        let urlString = "\(baseURL)?lat=\(city.lat)&lon=\(city.long)&appid=\(apiKey)&units=metric";
        
        guard let url = URL(string: urlString) else {return}
        
        let task = session.dataTask(with: url) {data, response, error in
            
            guard let data else{
                completion(nil);
                return
            }
            
            do{
                let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data);
                completion(forecastResponse);
            } catch {
                print(error);
                completion(nil);
            }
        }
        
        task.resume();
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let current: Forecast?
    let hourly: [Forecast]
    let daily: [DailyForecast]
}

// MARK: - Forecast
struct Forecast: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

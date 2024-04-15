//
//  WeatherModel.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 15/04/24.
//

import Foundation

/*
Model for the JSON like below
https://api.openweathermap.org/data/2.5/forecast?lat=16.180597&lon=81.124883&appid=df5baa7db19cc94129443d36bb458d95
 {
   "cod": "200",
   "message": 0,
   "cnt": 40,
   "list": [
     {
       "dt": 1713204000,
       "main": {
         "temp": 301.53,
         "feels_like": 304.57,
         "temp_min": 301.53,
         "temp_max": 301.68,
         "pressure": 1011,
         "sea_level": 1011,
         "grnd_level": 1010,
         "humidity": 70,
         "temp_kf": -0.15
       },
       "weather": [
         {
           "id": 800,
           "main": "Clear",
           "description": "clear sky",
           "icon": "01n"
         }
       ],
       "clouds": {
         "all": 2
       },
       "wind": {
         "speed": 3.46,
         "deg": 194,
         "gust": 7.22
       },
       "visibility": 10000,
       "pop": 0,
       "sys": {
         "pod": "n"
       },
       "dt_txt": "2024-04-15 18:00:00"
     }
    ],
   "city": {
     "id": 1264637,
     "name": "Machilipatnam",
     "coord": {
       "lat": 16.1806,
       "lon": 81.1249
     },
     "country": "IN",
     "population": 192827,
     "timezone": 19800,
     "sunrise": 1713140414,
     "sunset": 1713185420
   }
 }
 */

struct WeatherResponse: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [WeatherData]
    let city: City
}

struct WeatherData: Codable {
    let dt: TimeInterval
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dt_txt: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Sys: Codable {
    let pod: String
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: TimeInterval
    let sunset: TimeInterval
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}

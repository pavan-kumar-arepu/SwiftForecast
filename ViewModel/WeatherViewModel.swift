//
//  WeatherViewModel.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 16/04/24.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherViewModel: ObservableObject {
    
    @Published private(set) var currentTemperature = String()
    @Published private(set) var currentCondition = String()
    @Published private(set) var dailyHighLow = "H:0 L:0"
    @Published private(set) var hourlyForecast = [HourWeather]()
    @Published private(set) var fiveDayForecast = [DayWeather]()
    
    private let weatherService = WeatherService()
    private let defaultLocation = CLLocation(latitude: 16.184883, longitude: 81.116815)
    init() {
        fetchCurrentWeather()
    }
    
    func fetchCurrentWeather() {
        
    }
}

struct HourWeather {
    let time: String
    let symbolName: String
    let temperature: String
}

struct DayWeather: Hashable {
    let day: String
    let symbolName: String
    let lowTemperature: String
    let highTemperature: String
}




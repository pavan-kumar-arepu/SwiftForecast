//
//  WeatherViewModel.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 16/04/24.
//

import Foundation
import WeatherKit
import CoreLocation

/**
 A view model class responsible for fetching weather data and providing it to the ContentView.
 */
class WeatherViewModel: ObservableObject {
    
    // MARK: Published Properties
    
    /// The current temperature to be displayed.
    @Published private(set) var currentTemperature = String()
    
    /// The current weather condition description.
    @Published private(set) var currentCondition = String()
    
    /// The daily high and low temperatures to be displayed.
    @Published private(set) var dailyHighLow = "H:0 L:0"
    
    /// The hourly forecast data to be displayed.
    @Published private(set) var hourlyForecast = [HourWeather]()
    
    /// The 5-day forecast data to be displayed.
    @Published private(set) var fiveDayForecast = [DayWeather]()
    
    // MARK: Private Properties
    
    /// The service responsible for fetching weather data.
    private let weatherService = WeatherService()
    
    /// The default location for which weather data is fetched.
    private let defaultLocation = CLLocation(latitude: 16.184883, longitude: 81.116815)
    
    // MARK: Initialization
    
    /**
     Initializes the WeatherViewModel and fetches current weather data.
     */
    init() {
        fetchCurrentWeather()
    }
    
    // MARK: Public Methods
    
    /**
     Fetches current weather data from the WeatherService.
     */
    func fetchCurrentWeather() {
        Task {
            do {
                let weather = try await weatherService.weather(for: defaultLocation)
                DispatchQueue.main.async {
                    // Update current temperature, condition, and daily high/low.
                    self.currentTemperature = weather.currentWeather.temperature.formatted()
                    self.currentCondition = weather.currentWeather.condition.description
                    self.dailyHighLow = "H:\(weather.dailyForecast.forecast[0].highTemperature.formatted().dropLast()) L:\(weather.dailyForecast.forecast[0].lowTemperature.formatted().dropLast())"
                    
                    // Populate hourly forecast data.
                    weather.hourlyForecast.forecast.prefix(24).forEach {
                        self.hourlyForecast.append(HourWeather(time: self.hourFormatter(date: $0.date), symbolName: $0.symbolName, temperature: "\($0.temperature.formatted().dropLast())"))
                    }
                    
                    // Populate 5-day forecast data.
                    weather.dailyForecast.forecast.prefix(5).forEach {
                        self.fiveDayForecast.append(DayWeather(day: self.dayFormatter(date: $0.date), symbolName: $0.symbolName, lowTemperature: "\($0.lowTemperature.formatted().dropLast())", highTemperature: "\($0.highTemperature.formatted().dropLast())"))
                    }
                }
            } catch {
                print("Error in fetch Weather Data", error)
            }
        }
    }
    
    // MARK: Private Methods
    
    /**
     Checks if date1 is the same hour or later than date2.
     
     - Parameters:
        - date1: The first date.
        - date2: The second date.
     - Returns: `true` if date1 is the same hour or later than date2, `false` otherwise.
     */
    private func isSameHourOrLater(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let comparisonResult = calendar.compare(date1, to: date2, toGranularity: .hour)
        return comparisonResult == .orderedSame || comparisonResult == .orderedDescending
    }
    
    /**
     Formats the date into hour format (e.g., "9AM").
     
     - Parameter date: The date to be formatted.
     - Returns: The formatted hour string.
     */
    private func hourFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        
        let calendar = Calendar.current
        
        let inputDateComponents = calendar.dateComponents([.day, .hour], from: date)
        let currentDateComponents = calendar.dateComponents([.day, .hour], from: Date())
        
        if inputDateComponents == currentDateComponents {
            return "Now"
        } else {
            return dateFormatter.string(from: date)
        }
    }
    
    /**
     Formats the date into day format (e.g., "Mon").
     
     - Parameter date: The date to be formatted.
     - Returns: The formatted day string.
     */
    private func dayFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        let calendar = Calendar.current
        
        let inputDateComponents = calendar.dateComponents([.day], from: date)
        let currentDateComponents = calendar.dateComponents([.day], from: Date())
        
        if inputDateComponents == currentDateComponents {
            return "Today"
        } else {
            return dateFormatter.string(from: date)
        }
    }
}

/**
 A structure representing hourly weather data.
 */
struct HourWeather {
    let time: String
    let symbolName: String
    let temperature: String
}

/**
 A structure representing daily weather data.
 */
struct DayWeather: Hashable {
    let day: String
    let symbolName: String
    let lowTemperature: String
    let highTemperature: String
}

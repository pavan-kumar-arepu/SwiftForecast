//
//  WeatherViewModel.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 16/04/24.
//

import Foundation
import CoreLocation
import WeatherKit


/**
 A view model responsible for managing weather-related data and interactions.
 
 The `WeatherViewModel` class is used to fetch and manage weather data for a specific location. It provides properties to store current weather conditions, hourly forecasts, and five-day forecasts. Additionally, it fetches the current location's name based on its coordinates and provides methods to format date and time strings.
 
 # Usage
 Initialize an instance of `WeatherViewModel` with the desired location's coordinates to fetch weather data. The class automatically updates its published properties when new weather data is fetched.
 
 # Example
 let viewModel = WeatherViewModel(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))
 
 - Author:  ArepuPavanKumar
 */

class WeatherViewModel: ObservableObject {
   
   // MARK: Published Properties
   
   /// The current temperature.
   @Published private(set) var currentTemperature = String()
   
   /// The current weather condition.
   @Published private(set) var currentCondition = String()
   
   /// The daily high and low temperatures.
   @Published private(set) var dailyHighLow = "H:0 L:0"
   
   /// The hourly forecast for the next 24 hours.
   @Published private(set) var hourlyForecast = [HourWeather]()
   
   /// The five-day forecast.
   @Published private(set) var fiveDayForecast = [DayWeather]()
   
   /// The name of the city or location.
   @Published private(set) var cityName = ""
   
   // MARK: Private Properties
   
   /// The service responsible for fetching weather data.
   private let weatherService = WeatherService()
   
   /// The coordinates of the location for which weather data is being fetched.
   private let coordinate: CLLocationCoordinate2D
   
   // MARK: Initialization
   
   /**
    Initializes the view model with the specified coordinates and fetches weather data.
    
    - Parameter coordinate: The coordinates of the location for which weather data is fetched.
    */
   init(coordinate: CLLocationCoordinate2D) {
       self.coordinate = coordinate
       fetchCurrentWeather()
   }
   
   // MARK: Public Methods
   
   /**
    Fetches the current weather data for the specified location.
    */
   func fetchCurrentWeather() {
       Task {
           do {
               let weather = try await weatherService.weather(for: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
               getAddressFromLocation(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
               
               DispatchQueue.main.async {
                   self.currentTemperature = weather.currentWeather.temperature.formatted()
                   self.currentCondition = weather.currentWeather.condition.description
                   self.dailyHighLow = "H:\(weather.dailyForecast.forecast[0].highTemperature.formatted().dropLast()) L:\(weather.dailyForecast.forecast[0].lowTemperature.formatted().dropLast())"
                   
                   // Hourly Forecast.
                   weather.hourlyForecast.forecast.prefix(24).forEach {
                       if self.isSameHourOrLater(date1: $0.date, date2: Date()) {
                           self.hourlyForecast.append(HourWeather(time: self.hourFormatter(date: $0.date), symbolName: $0.symbolName, temperature:  "\($0.temperature.formatted().dropLast())"))
                       }
                   }
                   
                   // 5 days Forecast.
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
    Checks if the specified date is the same hour or later than the current date.
    
    - Parameters:
       - date1: The first date to compare.
       - date2: The second date to compare (usually the current date).
    - Returns: `true` if `date1` is the same hour or later than `date2`, otherwise `false`.
    */
   private func isSameHourOrLater(date1: Date, date2: Date) -> Bool {
       let calender = Calendar.current
       let comparisionResult = calender.compare(date1, to: date2, toGranularity: .hour)
       
       return comparisionResult == .orderedSame || comparisionResult == .orderedDescending
   }
   
   /**
    Formats the specified date into a string representing the hour.
    
    - Parameter date: The date to format.
    - Returns: A string representing the hour.
    */
   private func hourFormatter(date: Date) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "ha"
       
       let calender = Calendar.current
       
       let inputDateComponents = calender.dateComponents([.day, .hour], from: date)
       let currentDateComponents = calender.dateComponents([.day, .hour], from: Date())
       
       if inputDateComponents == currentDateComponents {
           return "Now"
       } else {
           return dateFormatter.string(from: date)
       }
   }
   
   /**
    Formats the specified date into a string representing the day.
    
    - Parameter date: The date to format.
    - Returns: A string representing the day.
    */
   private func dayFormatter(date: Date) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "EEE"
       
       let calender = Calendar.current
       
       let inputDateComponents = calender.dateComponents([.day], from: date)
       let currentDateComponents = calender.dateComponents([.day], from: Date())
       
       if inputDateComponents == currentDateComponents {
           return "Today"
       } else {
           return dateFormatter.string(from: date)
       }
   }
   
   /**
    Retrieves the address (city name) from the specified location and updates the `cityName` property.
    
    - Parameter location: The location for which to retrieve the address.
    */
   private func getAddressFromLocation(location: CLLocation) {
       let geocoder = CLGeocoder()
       geocoder.reverseGeocodeLocation(location) { placemarks, error in
           guard let placemark = placemarks?.first else {
               print("Unable to reverse geocode")
               return
           }
           
           if let name = placemark.subAdministrativeArea {
               self.cityName = name
               print("CityName:", name)
           } else {
               self.cityName = "Unknown Place"
           }
       }
   }
}


/**
 Represents the weather forecast for a specific hour.
 
 The `HourWeather` struct contains information about the time, weather symbol name, and temperature for a specific hour in the forecast.
 
 # Usage
 Use this struct to represent hourly weather forecasts in your weather-related applications.
 
 # Example
 let hourWeather = HourWeather(time: "12PM", symbolName: "sun.max", temperature: "25°C")

 */

struct HourWeather {
   /// The time of the hour in 12-hour format (e.g., "12PM").
   let time: String
   
   /// The symbol name representing the weather condition (e.g., "sun.max").
   let symbolName: String
   
   /// The temperature at the specified hour.
   let temperature: String
}


/**
 Represents the weather forecast for a specific day.
 
 The `DayWeather` struct contains information about the day, weather symbol name, low temperature, and high temperature for a specific day in the forecast.
 
 # Usage
 Use this struct to represent daily weather forecasts in your weather-related applications.
 
 # Example
 struct DayWeather: Hashable {
 let day: String
 let symbolName: String
 let lowTemperature: String
 let highTemperature: String
 }
 let dayWeather = DayWeather(day: "Monday", symbolName: "cloud.sun", lowTemperature: "15°C", highTemperature: "25°C")

 */

struct DayWeather: Hashable {
   /// The day of the week (e.g., "Monday").
   let day: String
   
   /// The symbol name representing the weather condition (e.g., "cloud.sun").
   let symbolName: String
   
   /// The low temperature for the day.
   let lowTemperature: String
   
   /// The high temperature for the day.
   let highTemperature: String
}

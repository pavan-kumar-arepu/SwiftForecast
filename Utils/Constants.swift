//
//  Constants.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 15/04/24.
//

import Foundation

/**
 Contains constant values used throughout the application.
 
 The `Constants` struct provides predefined constant values for various purposes, such as labels, system images, and other static data used across the application.
 
 # Usage
 Access the constant values using dot notation, for example:
 
 let hourlyForecastLabel = Constants.hourlyForecast
 let systemClockImage = Constants.systemClock
 
 # Example
 let daywiseForecastLabel = Constants.daywiseForecast
 
 - Author:  ArepuPavanKumar
 */
struct Constants {
   /// Constant representing the label for hourly weather forecast.
   static let hourlyForecast = "Hourly Forecast"
   
   /// Constant representing the label for 5-day weather forecast.
   static let daywiseForecast = "5-Days Forecast"
   
   /// Constant representing the system image name for clock icon.
   static let systemClock = "clock"
}

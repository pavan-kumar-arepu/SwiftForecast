//
//  WeatherView.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 16/04/24.
//

import Foundation
import SwiftUI

/**
 A SwiftUI view displaying weather information, including current conditions, hourly forecast, and 5-day forecast.
 */
struct WeatherView: View {
    
    // MARK: State
    
    /// The view model responsible for managing weather data.
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            // Apply gradient background to the entire view
            LinearGradient(gradient: Gradient(colors: [.blue, .blue, .green]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.vertical)
            
            // Scrollable view to display weather information
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    // Display city name
                    Text("Hyderabad")
                        .font(.title)
                    
                    // Display current temperature
                    Text(weatherViewModel.currentTemperature.dropLast())
                        .font(.system(size: 72))
                        .fontWeight(.light)
                    
                    // Display current weather condition
                    Text(weatherViewModel.currentCondition)
                    
                    // Display daily high and low temperatures
                    Text(weatherViewModel.dailyHighLow)
                }
                .foregroundColor(.white)
                .padding()
                
                // Display hourly forecast
                VStack(alignment: .leading) {
                    Label("hourly forecast".uppercased(), systemImage:  "clock")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(weatherViewModel.hourlyForecast, id: \.time) { weather in
                                VStack(spacing: 12) {
                                    // Display time
                                    Text(weather.time)
                                        .font(.caption)
                                    // Display weather symbol
                                    Image(systemName: "\(weather.symbolName).fill")
                                        .font(.title2)
                                        .symbolRenderingMode(.multicolor)
                                    // Display temperature
                                    Text(weather.temperature)
                                        .fontWeight(.semibold)
                                }
                                .padding()
                            }
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                .padding()
                
                // Display 5-day forecast
                VStack(alignment: .leading) {
                    Label("5-days forecast".uppercased(), systemImage: "clock")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                    
                    VStack {
                        ForEach(weatherViewModel.fiveDayForecast, id: \.self) { weather in
                            HStack {
                                // Display day
                                Text(weather.day)
                                    .frame(width: 48, alignment: .leading)
                                
                                // Display weather symbol
                                Image(systemName: "\(weather.symbolName).fill")
                                    .font(.title2)
                                    .padding(.horizontal)
                                    .symbolRenderingMode(.multicolor)
                                
                                // Display low temperature
                                Text(weather.lowTemperature)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.gray)
                                
                                // Display temperature range
                                ZStack(alignment: .trailing) {
                                    Capsule()
                                    
                                    LinearGradient(gradient: Gradient(colors: [.blue, .yellow]),
                                                   startPoint: .leading, endPoint: .trailing)
                                    .clipShape(Capsule())
                                    .frame(width: 72)
                                }
                                .frame(height: 6)
                                
                                // Display high temperature
                                Text(weather.highTemperature)
                                    .fontWeight(.semibold)
                            }
                            .padding()
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                .padding()
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

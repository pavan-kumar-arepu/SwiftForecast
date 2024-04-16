//
//  WeatherView.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 16/04/24.
//

import Foundation
import SwiftUI

struct WeatherView: View {
    
    @StateObject private var weatherViewModel = WeatherViewModel()
    var body: some View {
        ZStack {
            // Apply Gradient, which is background to complete view
            LinearGradient(gradient: Gradient(colors: [.blue, .blue, .green]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.vertical)
            
            // ScrollView to show Major Temp, Condition and Low and High values

            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    Text("Hyderabad")
                        .font(.title)
                    
                    Text(weatherViewModel.currentTemperature.dropLast())
                        .font(.system(size: 72))
                        .fontWeight(.light)
                    
                    Text(weatherViewModel.currentCondition)
                    
                    Text(weatherViewModel.dailyHighLow)
                    
                }
                .foregroundColor(.white)
                .padding()
                
                // Provide a VStack to show Hourly data

                VStack(alignment: .leading) {
                    Label("hourly forecast".uppercased(), systemImage:  "clock")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(weatherViewModel.hourlyForecast, id: \.time) {
                                weather in
                                VStack(spacing: 12) {
                                    Text(weather.time)
                                        .font(.caption)
                                    Image(systemName: "\(weather.symbolName).fill")
                                        .font(.title2)
                                        .symbolRenderingMode(.multicolor)
                                    
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
            }
                
            
            // Provide a VStack to show 5 days forecast data
        }
              
    }
}
                       
             
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

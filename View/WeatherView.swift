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
            }
                
            
            // ScrollView to show Major Temp, Condition and Low and High values
            
            
            // Provide a VStack to show Hourly data
            
            
            // Provide a VStack to show 5 days forecast data
        }
              
    }
}
                       
             
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

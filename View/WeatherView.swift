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
            
            Text("UI Yet To Develop")
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

//
//  WeatherView.swift
//  WeatherKitApp
//
//  Created by Arepu Pavan Kumar on 2024-04-16.
//

import Foundation
import SwiftUI
import CoreLocation

/**
 A custom view for displaying weather information.
 
 This view presents weather data including current conditions, hourly forecast, and 5-days forecast. It allows users to see detailed weather information based on their location or a selected coordinate.
 
 # Usage
 Initialize the view by providing a coordinate representing the location for which weather data is fetched. The view fetches weather data based on the provided coordinate.
 
 # Example:
 let defaultLocation = CLLocation(latitude: 59.363339, longitude: 18.012605)
 CustomWeatherView(coordinate: CLLocationCoordinate2D(latitude: defaultLocation.coordinate.latitude,
 longitude: defaultLocation.coordinate.longitude))
 
 - Author:  ArepuPavanKumar
 */
struct CustomWeatherView: View {
    
    // MARK: Properties
    
    /// The coordinate representing the location for which weather data is fetched.
    let coordinate: CLLocationCoordinate2D
    
    /// The view model responsible for fetching weather data.
    @StateObject private var weatherViewModel: WeatherViewModel
    
    // MARK: Initialization
    
    /// Initializes the view with the specified coordinate.
    /// - Parameter coordinate: The coordinate representing the location for which weather data is fetched.
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self._weatherViewModel = StateObject(wrappedValue: WeatherViewModel(coordinate: coordinate))
    }
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [.blue, .blue, .green]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.vertical)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    Text(weatherViewModel.cityName)
                        .font(.title)
                    
                    Text(weatherViewModel.currentTemperature.dropLast())
                        .font(.system(size: 72))
                        .fontWeight(.light)
                    
                    Text(weatherViewModel.currentCondition)
                    
                    Text(weatherViewModel.dailyHighLow)
                }
                .foregroundColor(.white)
                .padding()
                
                VStack(alignment: .leading) {
                    Label(Constants.hourlyForecast.uppercased(), systemImage:  Constants.systemClock)
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
                
                VStack(alignment: .leading) {
                    Label(Constants.daywiseForecast.uppercased(), systemImage: Constants.systemClock)
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                    
                    VStack{
                        ForEach(weatherViewModel.fiveDayForecast, id: \.self) {
                            weather in
                            HStack {
                                Text(weather.day)
                                    .frame(width: 48, alignment: .leading)
                                
                                Image(systemName: "\(weather.symbolName).fill")
                                    .font(.title2)
                                    .padding(.horizontal)
                                    .symbolRenderingMode(.multicolor)
                                
                                Text(weather.lowTemperature)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.gray)
                                
                                ZStack(alignment: .trailing) {
                                    Capsule()
                                    
                                    LinearGradient(gradient: Gradient(colors: [.blue, .yellow]),
                                                   startPoint: .leading, endPoint: .trailing)
                                    .clipShape(Capsule())
                                    .frame(width: 72)
                                }
                                .frame(height: 6)
                                
                                Text(weather.highTemperature)
                                    .fontWeight(.semibold)
                            }.padding()
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                .padding()
            }
        }
    }
}

// MARK: Preview

struct CustomWeatherView_Previews: PreviewProvider {
   
   static var previews: some View {
       let defaultLocation = CLLocation(latitude: 59.363339, longitude: 18.012605)
       CustomWeatherView(coordinate: CLLocationCoordinate2D(latitude: defaultLocation.coordinate.latitude,
                                                      longitude: defaultLocation.coordinate.longitude))
   }
}

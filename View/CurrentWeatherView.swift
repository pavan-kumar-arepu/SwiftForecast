//
//  CurrentWeatherView.swift
//  WeatherKitApp
//
//  Created by Arepu Pavan Kumar on 2024-04-16.
//

import SwiftUI
import CoreLocation

/**
 A view for displaying the current weather information.
 
 This view allows users to see the current weather conditions based on their location or a selected city. It includes a search field for entering a city name, and a button for fetching weather data either based on the entered city or the user's current location.
 
 # Usage
 Initialize the view by providing a coordinate representing the user's location or a default location. The view fetches weather data based on the provided coordinate.
 
 # Example
 let defaultLocation = CLLocation(latitude: 59.363339, longitude: 18.012605)
 CurrentWeatherView(coordinate: CLLocationCoordinate2D(latitude: defaultLocation.coordinate.latitude,
 longitude: defaultLocation.coordinate.longitude))
 
 - Author:  ArepuPavanKumar
 */

struct CurrentWeatherView: View {
   
   // MARK: Properties
   
   /// The coordinate representing the location for which weather data is fetched.
   let coordinate: CLLocationCoordinate2D
   
   /// The view model responsible for fetching weather data.
   @StateObject private var weatherViewModel: WeatherViewModel
   
   /// The location manager for accessing the user's current location.
   @StateObject var locationManager = LocationManager()
   
   /// The user's current location.
   @State private var userLocation: CLLocationCoordinate2D?
   
   /// The name of the selected city for which weather data is fetched.
   @State private var selectedCity: String = ""
   
   /// A boolean value indicating whether to present the weather view.
   @State private var showWeatherView = false
   
   // MARK: Initialization
   
   /// Initializes the view with the specified coordinate.
   /// - Parameter coordinate: The coordinate representing the location for which weather data is fetched.
   init(coordinate: CLLocationCoordinate2D) {
       self.coordinate = coordinate
       self._weatherViewModel = StateObject(wrappedValue: WeatherViewModel(coordinate: coordinate))
   }
   
   // MARK: Body
   
   var body: some View {
       
       NavigationView {
           ZStack {
               
               // Background gradient
               LinearGradient(gradient: Gradient(colors: [.green, .blue]),
                              startPoint: .top,
                              endPoint: .bottom)
                   .edgesIgnoringSafeArea(.vertical)
               
               ScrollView(showsIndicators: false) {
                   VStack(spacing: 8) {
                       
                       // Search field and button
                       HStack {
                           TextField("Enter City Name", text: $selectedCity)
                               .opacity(1.0)
                               .padding()
                               .frame(height: 50)
                               .background(Color.white)
                               .cornerRadius(8)
                               .foregroundColor(.blue)
                               .padding(.horizontal, 5)
                               .foregroundColor(Color.gray.opacity(1.0))
                           
                           Button(action:{
                               if let lastLocation = locationManager.lastLocation {
                                   userLocation = lastLocation.coordinate
                               }
                               if !selectedCity.isEmpty {
                                   fetchWeatherForCity()
                               } else if userLocation != nil {
                                   showWeatherView = true
                               } else {
                                   print("No location Provided")
                               }
                           }) {
                               Image(systemName: "arrow.up")
                                   .padding()
                                   .background(Color.white)
                                   .foregroundColor(.blue)
                                   .cornerRadius(8)
                           }
                       }
                       
                       // Weather information
                       Spacer()
                       
                       Divider()
                           .background(Color.white)
                       Spacer()
                       
                       Text(weatherViewModel.cityName)
                           .font(.title)
                       
                       Text(weatherViewModel.currentTemperature.dropLast())
                           .font(.system(size: 72))
                           .fontWeight(.light)
                       
                       Text(weatherViewModel.currentCondition)
                       
                       Text(weatherViewModel.dailyHighLow)
                           .foregroundColor(.white)
                           .padding()
                   }
                   .sheet(isPresented: $showWeatherView) {
                       if !selectedCity.isEmpty {
                           if userLocation != nil {
                               CustomWeatherView(coordinate: CLLocationCoordinate2D(latitude: userLocation?.latitude ?? 59.36282446, longitude: userLocation?.longitude ?? 18.00344537))
                           }
                       } else if let userLocation = locationManager.lastLocation {
                           CustomWeatherView(coordinate: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude))
                       } else {
                           Text("No Location available")
                       }
                   }
               }
               .foregroundColor(.white)
               .padding()
           }
           .navigationBarTitle("Swiftly Forecast", displayMode: .large)
       }
   }
   
   // MARK: Methods
   
   /// Fetches weather data for the selected city.
   private func fetchWeatherForCity() {
       let geocoder = CLGeocoder()
       geocoder.geocodeAddressString(selectedCity) { placemarks, error in
           guard let placemark = placemarks?.first, let location = placemark.location else {
               print("Unable to geocode cityname")
               return
           }
           
           // Get Lati and Longi
           userLocation = location.coordinate
           showWeatherView = true
       }
   }
}

// MARK: Preview

struct CurrentWeatherView_Previews: PreviewProvider {
   
   static var previews: some View {
       let defaultLocation = CLLocation(latitude: 59.363339, longitude: 18.012605)
       CurrentWeatherView(coordinate: CLLocationCoordinate2D(latitude: defaultLocation.coordinate.latitude,
                                                             longitude: defaultLocation.coordinate.longitude))
   }
}

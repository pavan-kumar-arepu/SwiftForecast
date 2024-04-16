//
//  ContentView.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 15/04/24.
//


/**
 The main view responsible for displaying weather information based on the user's current location.
 
 This view utilizes a `LocationManager` to obtain the user's current location. If the location is available, it initializes and presents the `CurrentWeatherView`, which displays weather data for the user's current location. If the location is not available, a placeholder message is displayed to inform the user that the app is waiting for their location.
 
 # Usage
 Initialize the view and present it as the root view of the application. The view automatically fetches the user's location and displays weather information based on that location.
 
 - Author: Your Name
 */

import SwiftUI
import CoreLocation
struct ContentView: View {
   
   // MARK: Properties
   
   /// The location manager responsible for obtaining the user's current location.
   @StateObject var locationManager = LocationManager()
   
   // MARK: Body
   
   var body: some View {
       // Check if the user's location is available
       if let userLocation = locationManager.lastLocation {
           // Present the CurrentWeatherView with the user's location coordinates
           CurrentWeatherView(coordinate: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude))
       } else {
           // Display a placeholder message when the location is not available
           Text("Waiting for location...")
       }
   }
}

// MARK: Preview

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       ContentView()
   }
}

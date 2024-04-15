//
//  SwiftForecastApp.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 15/04/24.
//

import SwiftUI
import GooglePlaces

@main
struct SwiftForecastApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear{
                    GMSPlacesClient.provideAPIKey("AIzaSyCC2XlY1AuGOcyEVipEglPo17uFOhRVZuw")
                }
        }
    }
}

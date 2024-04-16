//
//  ContentView.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 15/04/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        WeatherView()
        .edgesIgnoringSafeArea(.vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


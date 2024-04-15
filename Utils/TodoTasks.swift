//
//  TodoTasks.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 15/04/24.
//

import Foundation

/*
 Tasks Todo
 -----------
 1. Finalise the WeatherAPI, set up the account and keep the APIKey ready
    Identified - https://openweathermap.org/forecast5
 2. Analyse the JSON first
 3. Based on JSON and available attributes, visualise the UI and think of the Model Object.
    Define the model classes based on the provided JSON structure.
 4. Finalise the UI (on Paper or Mind)
 5. Create Project Structure - MVVM
 6. Keep the Weather data ready by preparing APILayer
 7. Preparation of APILayer which involves many things - Write necessary APILayers classes using URLSession, Model, Parsers and Prepare objects skelteon ready to consume in UI
 8. Keep the Repository Ready to facilitate date to VM's
 9. Create VM's and consume data from Repository(where data is always ready)
 10. Create two SwiftUI Views SearchWeatherView and DetailedWeatherView
 11. SearchWeatherView responsible to search the "City" from the search field -
    Based on city search, need to fetch its Lat, Lan, by using GoogleGeoCodingAPI or any otherAPI..
 12. Once Lat, Lan retrived from GoogleAPI, need to hit https://api.openweathermap.org/data/2.5/forecast?lat=16.180597&lon=81.124883&appid={APIKey}
 13. Based on the data retrived, APILayer will parse and keep the real weatherObject ready. Repository will facility data to DetailedWeatherView VM's to render DetailedWeatherView
 */

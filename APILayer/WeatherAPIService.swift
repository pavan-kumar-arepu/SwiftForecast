//
//  WeatherAPIService.swift
//  SwiftForecast
//
//  Created by Pavankumar Arepu on 15/04/24.
//

import Foundation
import Foundation

class WeatherAPIService {
    // MARK: - Properties
    
    // Replace "YOUR_API_KEY" with your actual OpenWeatherMap API key
    private let apiKey = "YOUR_API_KEY"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/forecast"
    
    // MARK: - Public Methods
    
    /// Fetches weather data from the OpenWeatherMap API based on latitude and longitude coordinates.
    ///
    /// - Parameters:
    ///   - latitude: The latitude coordinate of the location.
    ///   - longitude: The longitude coordinate of the location.
    ///   - completion: The completion handler to call when the request is complete.
    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        // Construct the URL with latitude, longitude, and API key
        let urlString = "\(baseUrl)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Create a URL session task for making the request
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check for valid HTTP response status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            // Check for data
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                // Parse the JSON data into the WeatherResponse model object
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// MARK: - Enums

/// Defines network-related errors.
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

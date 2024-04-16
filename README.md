# SwiftForecast
A quick weather Forecast using SwiftUI

## Overview

SwiftForecast is a mobile application that provides users with real-time weather updates for their current location or any city worldwide. The app offers hourly and 5-day forecasts, allowing users to stay informed about upcoming weather conditions.

## Motivation/Inspiration
Apple WeatherAppUI is an inspiration to design this app UI(but with limited functionality)

## Features

- Current weather display for the user's location.
- Hourly forecast for the next 24 hours.
- 5-day forecast for any selected city.
- Search functionality to find weather forecasts for specific cities.
- User-friendly interface with intuitive navigation.
- Utilizes WeatherKitAPI from Apple proprietary for weather data, eliminating the need for third-party APIs.

## Screenshots

![DefaultCurrentWeather](https://github.com/pavan-kumar-arepu/SwiftForecast/assets/13812858/cf01f9d9-7dbc-465d-bb93-0fe1f5ec3faa)
![BeforeSearch](https://github.com/pavan-kumar-arepu/SwiftForecast/assets/13812858/934122fb-ade8-4aef-bce2-941be6cfa0b9)
![WhileSearch](https://github.com/pavan-kumar-arepu/SwiftForecast/assets/13812858/85d90243-eafc-4748-93a4-6f53fb6dccc6)
![HyderabadForecast](https://github.com/pavan-kumar-arepu/SwiftForecast/assets/13812858/b947cb9c-f366-4414-a0b2-4f598c048eff)
![DubaiForecast](https://github.com/pavan-kumar-arepu/SwiftForecast/assets/13812858/8f129005-1ed5-47cd-9370-93d95bb20795)
![SearchDubai](https://github.com/pavan-kumar-arepu/SwiftForecast/assets/13812858/212aaa38-5cca-4fb1-a200-d6c759adc43e)

## Technologies Used

- SwiftUI: Used for building the user interface.
- Swift Concurrency: Utilized for asynchronous programming using features like async and await, enhancing the responsiveness of the app.
- CoreLocation: Integrated for location services and geocoding.
- OpenWeatherMap API: Used for fetching weather data.
- MVVM Architecture: Followed to maintain separation of concerns and facilitate testing.

## Installation

1. Clone the repository.
2. Open the project in Xcode.
3. Build and run the app on a simulator or a physical device.

## How to Use

1. Upon launching the app, the current weather for the user's location is displayed.
2. Make sure to provide location access to the app(from the alerts asked by app)
3. Use the search bar to enter the name of a city to view its weather forecast.
4. Navigate through the hourly (Horizontal Scroll, where it will show the 1-day hourly forecast)
5. Benieth the Hourly forecast, we have 5-day forecasts(which is a vertical scroll)
6. Swipe down to search new city


## Contact

For any inquiries or feedback, please contact:
- Name:  Arepu Pavan Kumar
- Email: iOSDeveloper.ipa@gmail.com
- Phone: +91 8121 04 03 08

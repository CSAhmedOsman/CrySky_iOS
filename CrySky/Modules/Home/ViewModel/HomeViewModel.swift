//
//  ViewModel.swift
//  CrySky
//
//  Created by Mac on 20/05/2024.
//

import Foundation

class HomeViewModel {
    
    private var services: Servicing
    private var weatherData: WeatherData? = nil
    private var locationManager : LocationManager
    
    init(services: Servicing, locationManager : LocationManager) {
        self.services = services
        self.locationManager = locationManager
    }
    
    func loadData(completion: @escaping (Bool) -> Void) {
        
        var lat = 31.0
        var lon = 29.0
        
        if let location = locationManager.location {
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
        }
        
        services.fetchData(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let data):
                print("Received weather data: \(data)")
                self?.weatherData = data
                completion(true)
            case .failure(let error):
                print("Error fetching weather data: \(error)")
                completion(false)
            }
        }
    }
    
    func getBackground() -> String{
        let hour = Calendar.current.component(.hour, from: Date())
        let image = (6...16).contains(hour) ? "Day" : "Night"
        return image
    }
    
    func getData() -> WeatherData? {
        return weatherData
    }
    
}

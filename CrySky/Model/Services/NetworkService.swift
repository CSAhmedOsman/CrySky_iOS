//
//  NetworkService.swift
//  CrySky
//
//  Created by Mac on 19/05/2024.
//

import Foundation
import Alamofire

protocol Servicing {
    func fetchData(lat: Double, lon: Double, completion: @escaping (Result<WeatherData,  Error>) -> Void)
}

class NetworkService: Servicing {
    
    private let APIkey = "b90bb0c9ecf54d2c911152109241905"
    private let urlPath = "http://api.weatherapi.com/v1/forecast.json"
    
    func fetchData(lat: Double, lon: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let url = "\(urlPath)?key=\(APIkey)&&q=\(lat),\(lon)&days=3&aqi=no&alerts=no"
        
        print(url)
        
        AF.request(url).responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

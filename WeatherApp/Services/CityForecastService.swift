//
//  CityForecastService.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 22/09/2024.
//

import Foundation

protocol CityForecastServiceProtocol {
    func getLocalCityForecast(cityId: Int, completionHandler: @escaping (CityForecastRealm) -> Void, failedHandler: @escaping (String?) -> Void)
    func getCityForecast(query: String, numberOfDays: Int, completionHandler: @escaping (CityForecastResponse) -> Void, failedHandler: @escaping (String?) -> Void)
}

class CityForecastService: CityForecastServiceProtocol {
    func getCityForecast(query: String, numberOfDays: Int, completionHandler: @escaping (CityForecastResponse) -> Void, failedHandler: @escaping (String?) -> Void) {
        let params = ["key" : ConfigEnvironment.shared.apiKey, "q" : query, "days": numberOfDays] as [String : Any]
        
        NetworkLayer.shared.makeRequest(endPoint: .forecast, method: .get, parameters: params, successHandler: { data in
            do {
                let citiesArray = try JSONDecoder().decode(CityForecastResponse.self, from: data)
                completionHandler(citiesArray)
            } catch {
                print("Error decoding data: \(error)")
                failedHandler("Error decoding data: \(error)")
            }
        }, failedHandler: failedHandler)
    }
    
    func getLocalCityForecast(cityId: Int, completionHandler: @escaping (CityForecastRealm) -> Void, failedHandler: @escaping (String?) -> Void) {
        if let city = RealmManager.shared.getObjectIfExist(CityRealm.self, remoteId: cityId) as? CityRealm, let forecast = city.forecast {
            completionHandler(forecast)
        } else {
            failedHandler("City is not saved in the DB")
        }
    }
}

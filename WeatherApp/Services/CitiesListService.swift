//
//  CitiesListService.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import Foundation

protocol CitiesListServiceProtocol {
    func getCitiesList(completionHandler: @escaping ([CityRealm]) -> Void)
    func searchForCity(query: String, completionHandler: @escaping ([City]) -> Void, failedHandler: @escaping (String?) -> Void)
}

class CitiesListService: CitiesListServiceProtocol {
    func getCitiesList(completionHandler: @escaping ([CityRealm]) -> Void) {
        
        let cities = RealmManager.shared.getAllDataFor(CityRealm.self)
        completionHandler(cities.map{$0 as! CityRealm})
    }
    
    func searchForCity(query: String, completionHandler: @escaping ([City]) -> Void, failedHandler: @escaping (String?) -> Void) {
        
        let params = ["key" : ConfigEnvironment.shared.apiKey, "q" : query]
        
        NetworkLayer.shared.makeRequest(endPoint: .search(query: query), method: .get, parameters: params, successHandler: { data in
            do {
                let citiesArray = try JSONDecoder().decode([City].self, from: data)
                completionHandler(citiesArray)
            } catch {
                failedHandler("Error decoding data: \(error)")
            }
        }, failedHandler: failedHandler)
    }
}

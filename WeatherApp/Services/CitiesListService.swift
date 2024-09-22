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
        
        NetworkLayer.shared.makeRequest(endPoint: .search, method: .get, parameters: params, successHandler: { data in
            do {
                let citiesArray = try JSONDecoder().decode([City].self, from: data)
                completionHandler(citiesArray)
            } catch {
                failedHandler("Error decoding data: \(error)")
            }
        }, failedHandler: failedHandler)
    }
}

class CitiesListFakeService: CitiesListServiceProtocol {
    func getCitiesList(completionHandler: @escaping ([CityRealm]) -> Void) {
        completionHandler(getFakeLocalCities())
    }
    
    func searchForCity(query: String, completionHandler: @escaping ([City]) -> Void, failedHandler: @escaping (String?) -> Void) {
        completionHandler(getFakeRemoteCities())
    }
    
    private func getFakeLocalCities() -> [CityRealm] {
        let city1 = CityRealm(cityId: 1, name: "Fake Local City 1", region: "", country: "", lat: 0.0, lon: 0.0, url: "", forecast: nil)
        let city2 = CityRealm(cityId: 2, name: "Fake Local City 2", region: "", country: "", lat: 0.0, lon: 0.0, url: "", forecast: nil)
        
        return [city1, city2]
    }
    
    private func getFakeRemoteCities() -> [City] {
        let city1 = City(id: 1, name: "Fake Remote City 1", region: "", country: "", lat: 0.0, lon: 0.0, url: "")
        let city2 = City(id: 2, name: "Fake Remote City 2", region: "", country: "", lat: 0.0, lon: 0.0, url: "")
        return [city1, city2]
    }
}

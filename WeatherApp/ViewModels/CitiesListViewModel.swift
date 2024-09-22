//
//  CitiesListViewModel.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import Foundation

protocol CitiesListViewModelProtocol {
    
    var view: CitiesListViewProtocol? { get set }
    var service: CitiesListServiceProtocol? { get set }
    var localCities: [CityRealm]? { get set }
    func getCitiesList()
    
}

class CitiesListViewModel: CitiesListViewModelProtocol {
    
    weak var view: CitiesListViewProtocol?
    var service: CitiesListServiceProtocol?
    var localCities: [CityRealm]?
    
    public init(service: CitiesListServiceProtocol?) {
        self.service = service
    }
    
    func getCitiesList() {
        view?.showLoader()
        
        service?.getCitiesList(completionHandler: {[weak self] cities in
            self?.view?.hideLoader()
            self?.localCities = cities
            self?.view?.citiesLoaded()
        })
    }
}

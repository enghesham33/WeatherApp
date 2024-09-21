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
    
    func getCitiesList()
    func searchForCity(query: String)
}

class CitiesListViewModel: CitiesListViewModelProtocol {
    
    weak var view: CitiesListViewProtocol?
    var service: CitiesListServiceProtocol?
    
    public init(service: CitiesListServiceProtocol?) {
        self.service = service
    }
    
    func getCitiesList() {
        view?.showLoader()
        
        service?.getCitiesList(completionHandler: {[weak self] cities in
            self?.view?.hideLoader()
            self?.view?.citiesLoaded(cities: cities)
        })
    }
    
    func searchForCity(query: String) {
        view?.showLoader()
        
        service?.searchForCity(query: query, completionHandler: { [weak self] cities in
            
            self?.view?.hideLoader()
            
        }, failedHandler: { [weak self] error in
            self?.view?.hideLoader()
            self?.view?.showToast(message: error)
        })
    }
}

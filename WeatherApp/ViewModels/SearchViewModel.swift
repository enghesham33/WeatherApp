//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 22/09/2024.
//

import Foundation

protocol SearchViewModelProtocol {
    
    var view: SearchViewProtocol? { get set }
    var service: CitiesListServiceProtocol? { get set }
    var remoteCities: [City]? { get set }
    
    func searchForCity(query: String)
    
}

class SearchViewModel: SearchViewModelProtocol {
    var view: SearchViewProtocol?
    var service: CitiesListServiceProtocol?
    var remoteCities: [City]?
    
    public init(service: CitiesListServiceProtocol?) {
        self.service = service
    }
    
    func searchForCity(query: String) {
        view?.showLoader()
        
        service?.searchForCity(query: query, completionHandler: { [weak self] cities in
            
            self?.view?.hideLoader()
            self?.remoteCities = cities
            self?.view?.citiesLoaded()
            
        }, failedHandler: { [weak self] error in
            self?.view?.hideLoader()
            self?.view?.showToast(message: error)
        })
    }
    
    
    
}

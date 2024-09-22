//
//  CityForecastViewModel.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 22/09/2024.
//

import Foundation

protocol CityForecastViewModelProtocol {
    
    var view: CityForecastViewProtocol? { get set }
    var service: CityForecastServiceProtocol? { get set }
    var remoteCityForecast: CityForecastResponse? { get set }
    var localCityForecast: CityForecastRealm? { get set }
    var remoteCity: City? { get set }
    var localCity: CityRealm? { get set }
    var isLocal: Bool { get }
    
    func saveCity()
    func getCityForecast()
    func refreshLocalForecast()
}

class CityForecastViewModel: CityForecastViewModelProtocol {
    var view: CityForecastViewProtocol?
    var service: CityForecastServiceProtocol?
    var remoteCityForecast: CityForecastResponse?
    var localCityForecast: CityForecastRealm?
    
    var remoteCity: City?
    var localCity: CityRealm?
    var isLocal: Bool {
        return localCity != nil
    }
    public init(service: CityForecastServiceProtocol?) {
        self.service = service
    }
        
    func saveCity() {
        
        guard let remoteCityForecast, let remoteCity else { return }
        
        let cityRealm = remoteCity.convertToCityRealm()
        cityRealm.forecast = remoteCityForecast.convertToCityForecastRealm()
        
        RealmManager.shared.add(cityRealm) { [weak self] in
            self?.view?.dataSaved()
        }
    }
    
    func getCityForecast() {
        view?.showLoader()
        
        if let localCity {
            getLocalForecast(cityId: localCity.cityId)
        } else {
            getRemoteForecast(cityName: remoteCity?.name ?? "")
        }
    }
    
    func refreshLocalForecast() {
        getRemoteForecast(cityName: localCity?.name ?? "") { [weak self] in
            if let localCity = self?.localCity {
                self?.refreshLocalForecast(cityRealm: localCity)
            }
        }
    }
    
    private func getLocalForecast(cityId: Int) {
        service?.getLocalCityForecast(cityId: cityId, completionHandler: { [weak self] forecast in
            self?.view?.hideLoader()
            self?.localCityForecast = forecast
            self?.view?.forecastLoaded()
        }, failedHandler: { [weak self] error in
            self?.view?.hideLoader()
            self?.view?.showToast(message: error)
        })
    }
    
    private func getRemoteForecast(cityName: String, completionHandler: (() -> Void)? = nil) {
        service?.getCityForecast(query: cityName, numberOfDays: 5, completionHandler: { [weak self] cityForecast in
            self?.view?.hideLoader()
            self?.remoteCityForecast = cityForecast
            completionHandler?()
            self?.view?.forecastLoaded()
        }, failedHandler: { [weak self] error in
            self?.view?.hideLoader()
            self?.view?.showToast(message: error)
        })
    }
    
    private func refreshLocalForecast(cityRealm: CityRealm) {
                
        RealmManager.shared.update { [weak self] in
            cityRealm.forecast = self?.remoteCityForecast?.convertToCityForecastRealm()
            self?.view?.dataSaved()
        }
    }
    
}

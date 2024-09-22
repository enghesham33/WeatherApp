//
//  Router.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import Foundation

class Router {
    class func citiesListViewController() -> CitiesViewController {
        return container.resolve(CitiesListViewProtocol.self) as! CitiesViewController
    }
    
    class func searchViewController() -> SearchViewController {
        return container.resolve(SearchViewProtocol.self) as! SearchViewController
    }
    
    class func cityForecastViewController(remoteCity: City? = nil, localCity: CityRealm? = nil) -> CityForecastViewController {
        let vc = container.resolve(CityForecastViewProtocol.self) as! CityForecastViewController
        vc.viewModel?.localCity = localCity
        vc.viewModel?.remoteCity = remoteCity
        return vc
    }
}

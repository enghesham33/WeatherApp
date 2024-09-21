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
}

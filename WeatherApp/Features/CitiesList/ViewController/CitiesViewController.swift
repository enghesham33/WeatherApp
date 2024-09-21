//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import UIKit

protocol CitiesListViewProtocol: BaseViewProtocol {
    var viewModel: CitiesListViewModelProtocol? { get set }
    func citiesLoaded(cities: [CityRealm])
}

class CitiesViewController: BaseViewController {
    
    var viewModel: CitiesListViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getCitiesList()
    }

}

extension CitiesViewController: CitiesListViewProtocol {
    func citiesLoaded(cities: [CityRealm]) {
        print("cities count :: \(cities.count)")
    }
}

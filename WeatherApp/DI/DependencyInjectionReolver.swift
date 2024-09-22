//
//  DependencyInjectionReolver.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import Foundation
import Swinject

let container = Container()

func resolveDependencyInjections() {
    resolveCitiesListDependencyInjections()
    resolveSearchDependencyInjections()
    resolveCityForecastDependencyInjections()
}

func resolveCitiesListDependencyInjections() {
    container.register(CitiesListServiceProtocol.self) { _ in CitiesListService() }
    
    container.register(CitiesListViewModelProtocol.self) { r in
        CitiesListViewModel(service: r.resolve(CitiesListServiceProtocol.self)!)
    }.initCompleted { r, viewModel in
        var viewModel = viewModel
        viewModel.view = r.resolve(CitiesListViewProtocol.self)
    }
    
    container.register(CitiesListViewProtocol.self) { r in
        CitiesViewController(nibName: "CitiesViewController", bundle: nil)
    }.initCompleted { r, vc in
        vc.viewModel = r.resolve(CitiesListViewModelProtocol.self)
    }
}

func resolveSearchDependencyInjections() {
    
    container.register(SearchViewModelProtocol.self) { r in
        SearchViewModel(service: r.resolve(CitiesListServiceProtocol.self)!)
    }.initCompleted { r, viewModel in
        var viewModel = viewModel
        viewModel.view = r.resolve(SearchViewProtocol.self)
    }
    
    container.register(SearchViewProtocol.self) { r in
        SearchViewController(nibName: "SearchViewController", bundle: nil)
    }.initCompleted { r, vc in
        vc.viewModel = r.resolve(SearchViewModelProtocol.self)
    }
}

func resolveCityForecastDependencyInjections() {
    container.register(CityForecastServiceProtocol.self) { _ in CityForecastService() }
    
    container.register(CityForecastViewModelProtocol.self) { r in
        CityForecastViewModel(service: r.resolve(CityForecastServiceProtocol.self)!)
    }.initCompleted { r, viewModel in
        var viewModel = viewModel
        viewModel.view = r.resolve(CityForecastViewProtocol.self)
    }
    
    container.register(CityForecastViewProtocol.self) { r in
        CityForecastViewController(nibName: "CityForecastViewController", bundle: nil)
    }.initCompleted { r, vc in
        vc.viewModel = r.resolve(CityForecastViewModelProtocol.self)
    }
    
}

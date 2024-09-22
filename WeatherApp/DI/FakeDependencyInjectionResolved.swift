//
//  FakeDependencyInjectionResolved.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 22/09/2024.
//

import Foundation

func resolveFakeDependencies() {
    resolveCitiesListFakeDependencyInjections()
    resolveSearchFakeDependencyInjections()
    resolveCityForecastFakeDependencyInjections()
}

func resolveCitiesListFakeDependencyInjections() {
    container.register(CitiesListServiceProtocol.self) { _ in CitiesListFakeService() }
    
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

func resolveSearchFakeDependencyInjections() {
    
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

func resolveCityForecastFakeDependencyInjections() {
    container.register(CityForecastServiceProtocol.self) { _ in CityForecastFakeService() }
    
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

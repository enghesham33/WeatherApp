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

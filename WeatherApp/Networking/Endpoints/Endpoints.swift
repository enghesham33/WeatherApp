//
//  Endpoints.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import Foundation

enum Endpoint {
    case search
    case forecast
    
    var url: String {
        switch self {
        case .search:
            return "\(ConfigEnvironment.shared.baseUrl)search.json"
        case .forecast:
            return "\(ConfigEnvironment.shared.baseUrl)forecast.json"
        }
    }
}

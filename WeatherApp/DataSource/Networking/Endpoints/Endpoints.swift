//
//  Endpoints.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import Foundation

enum Endpoint {
    case search(query: String)
    case forecast(query: String, daysNumber: Int)
    
    var url: String {
        switch self {
        case .search(let query):
            return "\(ConfigEnvironment.shared.baseUrl)search.json"
        case .forecast(let query, let daysNumber):
            return "\(ConfigEnvironment.shared.baseUrl)forecast.json"
        }
    }
}

//
//  SearchResponse.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import Foundation

struct City: Codable {
    var id: Int?
    var name: String?
    var region: String?
    var country: String?
    var lat: Double?
    var lon: Double?
    var url: String?
    
    func convertToCityRealm() -> CityRealm {
        return CityRealm(
            cityId: id ?? 0,
            name: name ?? "",
            region: region ?? "",
            country: country ?? "",
            lat: lat ?? 0.0,
            lon: lon ?? 0.0,
            url: url ?? ""
        )
    }
}

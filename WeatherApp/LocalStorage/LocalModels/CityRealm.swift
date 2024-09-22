//
//  CityRealm.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import Foundation
import RealmSwift

class CityRealm: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var cityId: Int = 0
    @Persisted var name: String = ""
    @Persisted var region: String = ""
    @Persisted var country: String = ""
    @Persisted var lat: Double = 0.0
    @Persisted var lon: Double = 0.0
    @Persisted var url: String = ""
    @Persisted var forecast: CityForecastRealm? = nil
    
    override init() {
        super.init()
    }
    
    init(
        cityId: Int,
        name: String,
        region: String,
        country: String,
        lat: Double,
        lon: Double,
        url: String,
        forecast: CityForecastRealm?
    ) {
        
        self.cityId = cityId
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
        self.url = url
        self.forecast = forecast
    }
    
    func convertToCity() -> City {
        return City(
            id: cityId,
            name: name,
            region: region,
            country: country,
            lat: lat,
            lon: lon,
            url: url
        )
    }
}

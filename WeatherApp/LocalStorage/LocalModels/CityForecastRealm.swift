//
//  CityForecastRealm.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 22/09/2024.
//

import Foundation
import RealmSwift

class CityForecastRealm: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var condition: ConditionRealm? = nil
    @Persisted var windKph: Double = 0.0
    @Persisted var humidity: Double = 0
    @Persisted var tempC: Double = 0.0
    @Persisted var days: List<DayRealm> = List<DayRealm>()
    
    override init() {
        super.init()
    }
    
    public init(
        condition: ConditionRealm?,
        windKph: Double,
        humidity: Double,
        tempC: Double,
        days: List<DayRealm>
    ) {
        self.condition = condition
        self.windKph = windKph
        self.humidity = humidity
        self.tempC = tempC
        self.days = days
    }
}

// MARK: - Condition
class ConditionRealm: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var text: String = ""
    @Persisted var icon: String = ""
    @Persisted var code: Int = 0
    
    override init() {
        super.init()
    }
    
    public init(
        text: String,
        icon: String,
        code: Int
    ) {
        self.text = text
        self.icon = icon
        self.code = code
    }
}

// MARK: - Day
class DayRealm: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var maxtempC: Double = 0.0
    @Persisted var mintempC: Double = 0.0
    @Persisted var date: String = ""
    @Persisted var condition: ConditionRealm? = nil
    
    
    override init() {
        super.init()
    }
    
    public init(
        maxtempC: Double,
        mintempC: Double,
        date: String,
        condition: ConditionRealm?
    ) {
        self.maxtempC = maxtempC
        self.mintempC = mintempC
        self.date = date
        self.condition = condition
    }
}

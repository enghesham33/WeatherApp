//
//  CityForecastResponse.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 22/09/2024.
//

import Foundation
import RealmSwift

// MARK: - CityForecastResponse
struct CityForecastResponse: Codable {
    let location: Location?
    let current: CurrentForecast?
    let forecast: Forecast?
    
    public init() {
        location = Location(name: "London", region: nil, country: nil, lat: nil, lon: nil, tzID: nil, localtimeEpoch: nil, localtime: nil)
        current = nil
        forecast = nil
    }
    
    func convertToCityForecastRealm() -> CityForecastRealm {
        let daysList = List<DayRealm>()
        daysList.append(
            objectsIn: forecast?.forecastDays?.compactMap({
                forecastDay in
                DayRealm(
                    maxtempC: forecastDay.day?.maxtempC ?? 0.0,
                    mintempC: forecastDay.day?.mintempC ?? 0.0,
                    date: forecastDay.date ?? "",
                    condition: forecastDay.day?.condition?.convertToConditionRealm() ?? ConditionRealm()
                )
            }) ?? []
        )
        
        return CityForecastRealm(
            condition: current?.condition?.convertToConditionRealm() ?? ConditionRealm(),
            windKph: current?.windKph ?? 0.0,
            humidity: current?.humidity ?? 0.0,
            tempC: current?.tempC ?? 0.0,
            days: daysList
        )
    }
}

// MARK: - CurrentForecast
struct CurrentForecast: Codable {
    let lastUpdatedEpoch: Int?
    let lastUpdated: String?
    let tempC, tempF: Double?
    let isDay: Int?
    let condition: Condition?
    let windMph, windKph: Double?
    let windDegree: Double?
    let windDir: String?
    let pressureMB: Double?
    let pressureIn: Double?
    let precipMm, precipIn, humidity, cloud: Double?
    let feelslikeC, feelslikeF, windchillC, windchillF: Double??
    let heatindexC, heatindexF, dewpointC, dewpointF: Double?
    let visKM, visMiles, uv: Double?
    let gustMph, gustKph: Double?
    let timeEpoch: Int?
    let time: String?
    let snowCM, willItRain, chanceOfRain, willItSnow: Int?
    let chanceOfSnow: Int?

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case timeEpoch = "time_epoch"
        case time
        case snowCM = "snow_cm"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String?
    let icon: String?
    let code: Int?
    
    func convertToConditionRealm() -> ConditionRealm {
        return ConditionRealm(text: text ?? "", icon: icon ?? "", code: code ?? 0)
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastDays: [ForecastDay]?
    
    enum CodingKeys: String, CodingKey {
        case forecastDays = "forecastday"
    }
}

// MARK: - Forecastday
struct ForecastDay: Codable {
    let date: String?
    let dateEpoch: Int?
    let day: Day?
    let astro: Astro?
    let hour: [CurrentForecast]?

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

// MARK: - Astro
struct Astro: Codable {
    let sunrise, sunset, moonrise, moonset: String
    let moonPhase: String
    let moonIllumination, isMoonUp, isSunUp: Int

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}

// MARK: - Day
struct Day: Codable {
    let maxtempC, maxtempF, mintempC, mintempF: Double?
    let avgtempC, avgtempF, maxwindMph, maxwindKph: Double?
    let totalprecipMm, totalprecipIn, totalsnowCM, avgvisKM: Double?
    let avgvisMiles, avghumidity, dailyWillItRain, dailyChanceOfRain: Int?
    let dailyWillItSnow, dailyChanceOfSnow: Int?
    let condition: Condition?
    let uv: Int?

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case totalsnowCM = "totalsnow_cm"
        case avgvisKM = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
    }
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String?
    let lat, lon: Double?
    let tzID: String?
    let localtimeEpoch: Int?
    let localtime: String?

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

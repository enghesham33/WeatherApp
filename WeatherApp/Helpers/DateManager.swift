//
//  DateManager.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 22/09/2024.
//

import Foundation

class DateManager {
    
    static func convertDateToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    static func convertStringToDate(dateString :String, format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return Date()
    }
}

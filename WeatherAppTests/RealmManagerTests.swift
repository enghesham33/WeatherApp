//
//  RealmManagerTests.swift
//  WeatherAppTests
//
//  Created by Mayar Khaled on 22/09/2024.
//

import XCTest
@testable import WeatherApp
import RealmSwift

final class RealmManagerTests: XCTestCase {
    
    var fakeCityForTesting = CityRealm(cityId: 10, name: "Test city", region: "Region 1", country: "Country 1", lat: 33.198273, lon: 35.198237, url: "test url", forecast: CityForecastRealm(condition: ConditionRealm(text: "Sunny", icon: "fake url", code: 10), windKph: 32.5, humidity: 50.5, tempC: 23.5, days: List<DayRealm>()))
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAdd() {
        RealmManager.shared.deleteAllDataFor(CityRealm.self)
        RealmManager.shared.add([fakeCityForTesting])
        XCTAssert(RealmManager.shared.getAllDataFor(CityRealm.self).count == 1)
    }
    
    func testGetByFilter() {
        XCTAssert(RealmManager.shared.getObjectIfExist(CityRealm.self, remoteId: 10) != nil)
    }
    
    func testDelete() {
        RealmManager.shared.deleteAllDataFor(CityRealm.self)
        XCTAssert(RealmManager.shared.getAllDataFor(CityRealm.self).count == 0)
    }
}

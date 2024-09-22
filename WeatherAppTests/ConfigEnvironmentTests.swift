//
//  ConfigEnvironmentTests.swift
//  WeatherAppTests
//
//  Created by Mayar Khaled on 22/09/2024.
//

import XCTest
@testable import WeatherApp

final class ConfigEnvironmentTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchEndPoint() {
        XCTAssert(ConfigEnvironment.shared.baseUrl == "http://api.weatherapi.com/v1/")
    }

    func testForecastEndPoint() {
        XCTAssert(ConfigEnvironment.shared.apiKey == "d42241632c0e420aa3c130524242009")
    }
}

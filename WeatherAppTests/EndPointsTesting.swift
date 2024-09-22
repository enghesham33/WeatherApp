//
//  EndPointsTesting.swift
//  WeatherAppTests
//
//  Created by Mayar Khaled on 22/09/2024.
//

import XCTest
@testable import WeatherApp

final class EndPointsTesting: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchEndPoint() {
        XCTAssert(Endpoint.search.url == "\(ConfigEnvironment.shared.baseUrl)search.json")
    }

    func testForecastEndPoint() {
        XCTAssert(Endpoint.forecast.url == "\(ConfigEnvironment.shared.baseUrl)forecast.json")
    }
}

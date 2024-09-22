//
//  CityForecastServiceTests.swift
//  WeatherAppTests
//
//  Created by Mayar Khaled on 22/09/2024.
//

import XCTest
@testable import WeatherApp

final class CityForecastServiceTests: XCTestCase {

    var service: CityForecastServiceProtocol?
    
    override func setUpWithError() throws {
        resolveFakeDependencies()
        service = Router.cityForecastViewController().viewModel?.service
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetLocalCityForecast() {
        service?.getLocalCityForecast(cityId: 1, completionHandler: { forecast in
            XCTAssert(forecast.condition != nil)
            XCTAssert(forecast.condition?.text == "Sunny")
            XCTAssert(forecast.condition?.code == 10)
            XCTAssert(forecast.windKph == 20.7)
            XCTAssert(forecast.humidity == 80.44)
            XCTAssert(forecast.tempC == 32.1)
            XCTAssert(forecast.days.count == 0)
        }, failedHandler: { error in
            print("error")
        })
    }

    func testGetCityForecast() {
        service?.getCityForecast(query: "", numberOfDays: 5, completionHandler: { forecast in
            XCTAssert(forecast.location != nil)
            XCTAssert(forecast.location?.name == "London")
        }, failedHandler: { error in
            print("error")
        })
    }
}


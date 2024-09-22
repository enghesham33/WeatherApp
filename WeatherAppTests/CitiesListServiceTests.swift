//
//  CitiesListServiceTests.swift
//  WeatherAppTests
//
//  Created by Mayar Khaled on 22/09/2024.
//

import XCTest
@testable import WeatherApp

final class CitiesListServiceTests: XCTestCase {

    var service: CitiesListServiceProtocol?
    
    override func setUpWithError() throws {
        resolveFakeDependencies()
        service = Router.citiesListViewController().viewModel?.service
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCitiesList() {
        service?.getCitiesList(completionHandler: { cities in
            XCTAssert(cities.count == 2)
            XCTAssert(cities.first?.name == "Fake Local City 1")
            XCTAssert(cities.last?.name == "Fake Local City 2")
        })
        
        
    }

    func testSearchForCity() {
        service?.searchForCity(query: "London", completionHandler: { cities in
            XCTAssert(cities.count == 2)
            XCTAssert(cities.first?.name == "Fake Remote City 1")
            XCTAssert(cities.last?.name == "Fake Remote City 2")
        }, failedHandler: { error in
            print("error")
        })
    }
}


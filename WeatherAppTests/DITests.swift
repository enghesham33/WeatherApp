//
//  DITests.swift
//  WeatherAppTests
//
//  Created by Mayar Khaled on 22/09/2024.
//

import XCTest
@testable import WeatherApp

final class DITests: XCTestCase {

    override func setUpWithError() throws {
        resolveDependencyInjections()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCitiesListScreen() {
        let vc = Router.citiesListViewController()
        XCTAssert(vc.viewModel != nil)
        XCTAssert(vc.viewModel?.service != nil)
        
    }
    
    func testSearchScreen() {
        let vc = Router.searchViewController()
        XCTAssert(vc.viewModel != nil)
        XCTAssert(vc.viewModel?.service != nil)
    }
    
    func testCityForecastScreen() {
        let vc = Router.cityForecastViewController()
        XCTAssert(vc.viewModel != nil)
        XCTAssert(vc.viewModel?.service != nil)
    }

}

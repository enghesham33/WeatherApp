//
//  DateManagerTests.swift
//  WeatherAppTests
//
//  Created by Mayar Khaled on 22/09/2024.
//

import XCTest
@testable import WeatherApp

final class DateManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConversion() {
        let givenDateString = "22-09-2024"
        let date = DateManager.convertStringToDate(dateString: givenDateString, format: "dd-MM-yyyy")
        let dateConvertedToString = DateManager.convertDateToString(date: date, format: "dd/MM/yyyy")
        let expectedResult = "22/09/2024"
        XCTAssert(dateConvertedToString == expectedResult)
    }

}

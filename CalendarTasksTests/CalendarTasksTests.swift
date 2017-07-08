//
//  CalendarTasksTests.swift
//  CalendarTasksTests
//
//  Created by radhakrishnan S on 07/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import XCTest
@testable import CalendarTasks
//@testable import
class CalendarTasksTests: XCTestCase {
    var dateFormatter : DateFormatter = DateFormatter()
    override func setUp() {
        super.setUp()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testNumberOfDaysInMonth()  {
        XCTAssert(28 == noOfdaysInMonth(month: 2, year: 2017), "No of days in February is 28")
        XCTAssert(29 == noOfdaysInMonth(month: 2, year: 2020), "No of days in February in a leap year is 29")
        XCTAssert(31 == noOfdaysInMonth(month: 5, year: 2023), "No of days in May 2023 is 31")
        
    }
    func testDateCreatedFromComponenets(){
        let date = dateFromComponents(year: 2017, month: 1, day: 1)
        XCTAssertNotNil(date, "Date can not be nil")
    }
    func testDateComponentItFormsCorrectDate(){
        let date = dateFromComponents(year: 2017, month: 1, day: 1)
        let dateString = "2017-1-1"
        let dateToCompare = dateFormatter.date(from: dateString)
        XCTAssertNotNil(dateToCompare, "Date from dateformatter can not be nil")
        XCTAssertEqualWithAccuracy(date!.timeIntervalSinceReferenceDate, dateToCompare!.timeIntervalSinceReferenceDate, accuracy: 0.00001, "Date created using date components is not equal to the original date")
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

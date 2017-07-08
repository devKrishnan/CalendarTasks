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
    func testYear() {
        let year = Year(currentYear: 2017)
        XCTAssertNotNil(year, "Year can not be nil")
        
        let invalidYear = Year(currentYear: -20119)
        XCTAssertNil(invalidYear, "Year can not be negative")
    }
    func testNoOfDaysInYear() {
        let year = Year(currentYear: 2017)
        XCTAssertNotNil(year, "Year can not be nil")
        
        let invalidYear = Year(currentYear: -20119)
        XCTAssertNil(invalidYear, "Year can not be negative")
    }
    func testMonth() {
        let invalidYearMonth = Month(ayear: 0 , aMonth: 1, aFirstDay: 1)
        XCTAssertNil(invalidYearMonth, "Month can not have year <= 0")
        
        let validMonth = Month(ayear: 1 , aMonth: 1, aFirstDay: 1)
        XCTAssertNotNil(validMonth, "Month can not be nil")
        
        let invalidMonth = Month(ayear: 1 , aMonth: -1, aFirstDay: -1)
        XCTAssertNil(invalidMonth, "Month can not be  <= 0")
        
    }
    func testTotalDaysInYear(){
        let year = Year(currentYear: 2017)
        XCTAssert(year?.totalDays == 365, "Not a leap year. Hence 365 days")
        
        let leapYear = Year(currentYear: 2020)
        XCTAssert(leapYear?.totalDays == 366, "Leap year. Hence 366 days")
    }
    func testDay() {
        let invalidDay = Day(aDay: -1, aMonth: 1, aYear: 1, aWeekday: 1, isLastDayInMonth: true)
        XCTAssertNil(invalidDay, "Day can not have year <= 0")
        
        let validDay = Day(aDay: 1, aMonth: 1, aYear: 1, aWeekday: 1, isLastDayInMonth: true)
        XCTAssertNotNil(validDay, "Day can not be nil")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

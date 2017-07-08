//
//  CalendarModelTests.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 08/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import XCTest

class CalendarModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    func testDayComparision() {
        let year = 2017
        let month = 12
        let day =  17
        let validDay = Day(aDay: day, aMonth: month, aYear: year, aWeekday: 1, isLastDayInMonth: false)
        XCTAssertNotNil(validDay, "Day can not be nil")
        let validDate = dateFromComponents(year: year, month: month, day: day)
        XCTAssertNotNil(validDate, "date can not be nil")
        XCTAssertTrue((validDay?.isEqualToDate(fromDate: validDate!))!, "Both the dates should be eqaul")
        
        
        let differentValidDate = dateFromComponents(year: year, month: month, day: day-1)
        XCTAssertNotNil(differentValidDate, "date can not be nil")
        XCTAssertFalse((validDay?.isEqualToDate(fromDate: differentValidDate!))!, "Both the dates should not be  eqaul")
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

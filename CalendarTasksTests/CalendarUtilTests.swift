//
//  CalendarUtilTests.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 08/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import XCTest

class CalendarUtilTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testYearsCreated() {
        let totalYears = 10
        let yearsCreated = years(beginYear: 2017, count: totalYears)
        XCTAssertNotNil(yearsCreated, "Years can not be nil")
        XCTAssert(yearsCreated?.count == totalYears , "Total no of years created should be " + String(totalYears))
        var beginYear : Int = 2017
        for year in yearsCreated! {
            XCTAssert(year.year == beginYear, "Year has to be eqaul")
            beginYear = beginYear + 1
        }
    }
    func testInvalidDayInMonthCreated() {
        //Day index begins from 0
        let day = 365
        let year = Year(currentYear: 2017)
        let (dayIndex, month) = dayInMonth(fromdayIndex: day, inYear: year!)
        XCTAssertNil(month, "366 is not a valid day")
        XCTAssertNil(dayIndex, "366 is not a valid day")
        
    }
    func testValidDayInMonthCreated() {
        //Day index begins from 0
        let day = 364
        
        if let year = Year(currentYear: 2017) {
            let (dayIndex, month) = dayInMonth(fromdayIndex: day, inYear: year)
            XCTAssertNotNil(month, "365 is  a valid day")
            XCTAssertNotNil(dayIndex, "365 is  a valid day")
            
            XCTAssertNotNil(month, "365 is  a valid day")
            XCTAssertNotNil(dayIndex, "365 is  a valid day")
            let decMonth = year.monthList.last
            XCTAssertEqual(month, decMonth, "The day Index refers to 31  December month")
            XCTAssertEqual(30 , dayIndex, "The day Index refers to 31  December month")
            
            XCTAssertNotEqual(31 , dayIndex, "The day Index refers to 31  December month")
        }else{
            XCTAssertTrue(false)
        }
       
        
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

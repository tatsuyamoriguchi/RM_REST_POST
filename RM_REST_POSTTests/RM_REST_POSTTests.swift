//
//  RM_REST_POSTTests.swift
//  RM_REST_POSTTests
//
//  Created by Tatsuya Moriguchi on 10/26/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import XCTest
@testable import RM_REST_POST

class RM_REST_POSTTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testgetMMMMddyyyySuccess() {
        // Given
        let testData = "May 9, 2020 8:09:03 PM"
        // When
        let result = String2Date().getMMMMddyyyy(data: testData)
        
        // Then
        // Expect successful
        XCTAssertEqual(result, "May 09, 2020")
        
    }
    
    func testgetMMMMddyyyyFail() {
        // Given
        let testData = "May 090, 2020 8:09:03 PM"
        // When
        let result = String2Date().getMMMMddyyyy(data: testData)
        
        // Then
        // Expect Fail
        XCTAssertEqual(result, "May 09, 2020")
        
    }
    
    


}

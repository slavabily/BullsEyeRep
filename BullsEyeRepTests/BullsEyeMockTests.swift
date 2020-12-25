//
//  BullsEyeMockTests.swift
//  BullsEyeRepTests
//
//  Created by slava bily on 25.12.2020.
//

import XCTest
@testable import BullsEyeRep

class MockUserDefaults: UserDefaults {
    var gameStyleChanged = 0
    
    override func set(_ value: Int, forKey defaultName: String) {
      if defaultName == "gameStyle" {
        gameStyleChanged += 1
      }
    }
}

class BullsEyeMockTests: XCTestCase {
    
    var sut: ContentView!
    var mockUserDefaults: MockUserDefaults!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = ContentView()
        mockUserDefaults = MockUserDefaults(suiteName: "testing")
          sut.defaults = mockUserDefaults
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
          mockUserDefaults = nil
          super.tearDown()
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

}

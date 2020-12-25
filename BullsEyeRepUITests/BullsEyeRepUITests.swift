//
//  BullsEyeRepUITests.swift
//  BullsEyeRepUITests
//
//  Created by slava bily on 18.12.2020.
//

import XCTest

class BullsEyeRepUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGamesStyleSwitch() throws {
        // UI tests must launch the application that they test.
        
        let tablesQuery = XCUIApplication().tables
        // given
        let slideButton = tablesQuery.segmentedControls.buttons["Slide"]
        let typeButton = tablesQuery.segmentedControls.buttons["Type"]
        let slideLabel = tablesQuery.staticTexts["Get as close as you can to: "]
        let typeLabel = tablesQuery.staticTexts["Guess where the slider is: "]
        
        // then
        
        if slideButton.isSelected {
//            XCTAssertTrue(slideLabel.exists)
            XCTAssertFalse(typeLabel.exists)
            
            typeButton.tap()
            XCTAssertTrue(typeLabel.exists)
            XCTAssertFalse(slideLabel.exists)
        } else if typeButton.isSelected {
            XCTAssertTrue(typeLabel.exists)
            XCTAssertFalse(slideLabel.exists)
            
            slideButton.tap()
//            XCTAssertTrue(slideLabel.exists)
            XCTAssertFalse(typeLabel.exists)
        }
        

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

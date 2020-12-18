//
//  BullsEyeRepTests.swift
//  BullsEyeRepTests
//
//  Created by slava bily on 18.12.2020.
//

import XCTest
@testable import BullsEyeRep

class BullsEyeRepTests: XCTestCase {
    
    var sut: BullsEyeGame!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = BullsEyeGame()
        sut.startNewGame()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testScoreIsComputed() {
        // given
        let guess = sut.targetValue + 5
        
        // when
        sut.check(guess: guess)
        
        // then
        XCTAssertEqual(sut.scoreRound, 95, "Scorecomputed from guess is wrong")
    }
    
    func testScoreIsComputedWhenGuessLTTarget() {
      // 1. given
      let guess = sut.targetValue - 5
      // 2. when
      sut.check(guess: guess)
      // 3. then
      XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
    }

}

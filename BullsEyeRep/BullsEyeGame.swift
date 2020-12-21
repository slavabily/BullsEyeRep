//
//  BullsEyeGame.swift
//  BullsEyeRep
//
//  Created by slava bily on 18.12.2020.
//

import Foundation

class BullsEyeGame: ObservableObject {
  var round = 0
  let startValue = 50
  @Published var targetValue = 50
  var scoreRound = 0
  var scoreTotal = 0
  
  init() {
    startNewGame()
  }
  
  func startNewGame() {
    round = 0
    scoreTotal = 0
    startNewRound()
  }
  
  func startNewRound() {
    round = round + 1
    scoreRound = 0
    targetValue = 1 + (Int(arc4random()) % 100)
  }

  @discardableResult
  func check(guess: Int) -> Int {
    let difference = abs(targetValue - guess)
//    let difference = guess - targetValue
    scoreRound = 100 - difference
    scoreTotal = scoreTotal + scoreRound
    
    return difference
  }
}


//
//  BullsEyeGame.swift
//  BullsEyeRep
//
//  Created by slava bily on 18.12.2020.
//

import Foundation

class BullsEyeGame: ObservableObject {
  @Published var round = 0
  @Published var startValue = 50
  @Published var targetValue = 50
  @Published var scoreRound = 0
  @Published var scoreTotal = 0
  
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
    print("\n model scoreRound = \(scoreRound)")
    scoreTotal = scoreTotal + scoreRound
    print("model scoreTotal = \(scoreTotal)")
    
    return difference
  }
}


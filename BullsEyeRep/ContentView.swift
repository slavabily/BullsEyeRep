//
//  ContentView.swift
//  BullsEyeRep
//
//  Created by slava bily on 18.12.2020.
//

import SwiftUI

struct ContentView: View {
    var defaults = UserDefaults.standard
    
    @ObservedObject var game = BullsEyeGame()
    
    enum GameStyle: Int {
        case moveSlider, guessPosition
    }
    
    var gameStyle: GameStyle {
        return GameStyle(rawValue: selectedGameStyle) ?? .guessPosition
    }
    
    @State private var targetGuessLabel = String()
    @State private var targetGuessText = String()
    @State private var sliderValue = 50.0
    @State private var selectedGameStyle = 0
    @State private var round = 0
    @State private var scoreRound = 0
    @State private var scoreTotal = 0
    
    @State private var showingAlert = false
    @State private var showingNanAlert = false
    
    let gameStyleRange = 0..<2
    
    var gameStyles = ["Slide", "Type"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        switch gameStyle {
                        case .moveSlider:
                            Text("\(targetGuessLabel) \(targetGuessText)")
                        case .guessPosition:
                            Text("\(targetGuessLabel)")
                            Spacer()
                            TextField(" 1-100", text: $targetGuessText)
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40, alignment: .trailing)
                                .border(Color.gray, width: 2)
                                .cornerRadius(5)
                        }
                    }
                    Slider(value: $sliderValue, in: 1...100, minimumValueLabel: Text("1"), maximumValueLabel: Text("100")) {
                    }
                }
                Button("Hit Me!") {
                    checkGuess()
                }
                .alert(isPresented: $showingNanAlert, content: { () -> Alert in
                    Alert(title: Text("Not A Number"), message: Text("Please enter a positive number"), dismissButton: .default(Text("Ok")))
                })
                .font(.title)
                .frame(width: 300, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Section {
                    Button("Start over") {
                        game.startNewGame()
                        updateView()
                    }
                    .font(.headline)
                    .frame(width: 300, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Section {
                    Picker(" ", selection: $selectedGameStyle) {
                        ForEach(0..<gameStyles.count) {
                            Text(gameStyles[$0])
                        }
                    }.onChange(of: selectedGameStyle, perform: { value in
                        print("\n value = \(value)")
                        defaults.setValue(value, forKey: "gameStyle")
                        updateView()
                    })
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("Round: \(round)")
                    Text("Score round: \(scoreRound)")
                    Text("Score total: \(scoreTotal)")
                }
                .frame(width: 300, height: 0, alignment: .center)
            }
            .onAppear {
                let defaultGameStyle = defaults.integer(forKey: "gameStyle")
                
                if gameStyleRange.contains(defaultGameStyle) {
                    print("defaultGameStyle = \(defaultGameStyle)")
                    selectedGameStyle = defaultGameStyle
                } else {
                    defaults.set(1, forKey: "gameStyle")
                }
                updateView()
            }
            .navigationBarTitle(Text("BullsEyeRep"))
            .alert(isPresented: $showingAlert, content: {
                   Alert(title: Text("You scored \(game.scoreRound) points"), message: Text("Target value \(game.targetValue) "), dismissButton: .default(Text("Ok")) {
                        print("\n targetValue = \(game.targetValue)")
                        game.startNewRound()
                        updateView()
                    })
            })
        }
    }
    
    func checkGuess() {
        var guess: Int?
        switch gameStyle {
        case .moveSlider:
            guess = Int(lround(sliderValue))
        case .guessPosition:
            guess = Int(targetGuessText)
        }
        if let guess = guess {
            print("\n guess = \(guess)")
            game.check(guess: guess)
            showingAlert.toggle()
        } else {
            showingNanAlert.toggle()
        }
    }
    
    func updateView() {
        switch gameStyle {
        case .moveSlider:
            targetGuessLabel = "Get as close as you can to: "
            targetGuessText = "\(game.targetValue)"
            sliderValue = Double(game.startValue)
        case .guessPosition:
            targetGuessLabel = "Guess where the slider is: "
            targetGuessText = ""
            sliderValue = Double(game.targetValue)
        }
        round = game.round
        scoreRound = game.scoreRound
        print("scoreRound = \(scoreRound)")
        scoreTotal = game.scoreTotal
        print("scoreTotal = \(scoreTotal)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  BullsEyeRep
//
//  Created by slava bily on 18.12.2020.
//

import SwiftUI

struct ContentView: View {
    var defaults = UserDefaults.standard
    
    @ObservedObject var bullsEyeGame = BullsEyeGame()
    
    enum GameStyle: Int {
        case moveSlider, guessPosition
    }
    
    var gameStyle: GameStyle {
        return GameStyle(rawValue: selectedGameStyle) ?? .guessPosition
    }
    
    @State private var targetGuess = String()
    @State private var sliderValue = 50.0
    @State private var selectedGameStyle = 0
    @State private var round = 0
    @State private var score = 0
    @State private var showingAlert = false
    
    var gameStyles = ["Slide", "Type"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        switch gameStyle {
                        case .moveSlider:
                            Text("Get as close as you can to: \(bullsEyeGame.targetValue)")
                        case .guessPosition:
                            Text("Guess where the slider is: ")
                            Spacer()
                            TextField(" 1-100", text: $targetGuess)
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40, alignment: .trailing)
                                .border(Color.gray, width: 2)
                                .cornerRadius(5)
                        }
                    }
                    Slider(value: $sliderValue, in: 1...100, minimumValueLabel: Text("1"), maximumValueLabel: Text("100")) {
                    }
                }
                
                Button("Hit Me!") {
                    if let guess = Int(targetGuess) {
                      let difference = bullsEyeGame.check(guess: guess)
                        // show score Alert
                        showingAlert.toggle()
                    }
                }
                .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("You scored \(bullsEyeGame.scoreRound) points"), message: Text("Target value \(bullsEyeGame.targetValue) "), dismissButton: .default(Text("Ok")))
                })
                .font(.title)
                .frame(width: 300, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Section {
                    Button("Start over") {
                        
                    }
                    .font(.headline)
                    .frame(width: 300, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                Section {
                    Picker(" ", selection: $selectedGameStyle) {
                        ForEach(0..<gameStyles.count) {
                            Text(gameStyles[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("Round: \(round)")
                    Text("Score: \(score)")
                }
                .frame(width: 300, height: 0, alignment: .center)
            }
            .navigationBarTitle(Text("BullsEyeRep"))
        }
    }
    
    func checkGuess(_ value: Int) {
         
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

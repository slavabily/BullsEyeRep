//
//  ContentView.swift
//  BullsEyeRep
//
//  Created by slava bily on 18.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var targetGuess = " "
    @State private var sliderValue = 50.0
    @State private var selectedGameStyle = 0
    @State private var round = 0
    @State private var score = 0
    
    var gameStyles = ["Slide", "Type"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Get close or guess where:")
                        TextField("", text: $targetGuess)
                    }
                    Slider(value: $sliderValue, in: 1...100, minimumValueLabel: Text("1"), maximumValueLabel: Text("100")) {
                        
                    }
                }
                Button("Hit Me!") {
                    
                }
                .frame(width: 300, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Section {
                    Button("Start over") {
                        
                    }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

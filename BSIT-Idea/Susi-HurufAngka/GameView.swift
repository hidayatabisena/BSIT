//
//  GameView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 01/04/23.
//

import SwiftUI

struct GameView: View {
    // properties
    @State private var currentLetterIndex = 0
    @State private var score = 0
    @State private var showAlert = false
    
    private let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    func randomLetterIndex() -> Int {
        var randomIndex = Int.random(in: 0..<letters.count)
        while randomIndex == currentLetterIndex {
            randomIndex = Int.random(in: 0..<letters.count)
        }
        return randomIndex
    }
    
    func checkAnswer(_ index: Int) {
        if index == 0 && letters[currentLetterIndex] < letters[randomLetterIndex()] {
            score += 1
        } else if index == 1 && letters[currentLetterIndex] > letters[randomLetterIndex()] {
            score += 1
        }
        
        currentLetterIndex += 1
        
        if currentLetterIndex == letters.count {
            showAlert = true
        }
    }
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Spacer()
            Text(String(letters[currentLetterIndex]))
                .font(.system(size: 120))
                .fontWeight(.bold)
                .padding(.bottom)
            HStack {
                Button(action: { checkAnswer(0) }) {
                    Text("A-Z")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                Button(action: { checkAnswer(1) }) {
                    Text("Z-A")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            Spacer()
        }
        .sheet(isPresented: $showAlert) {
            VStack {
                Text("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("You have reached the end of the alphabet. Your final score is \(score)")
                    .multilineTextAlignment(.center)
                    .padding()
                Button("Restart") {
                    currentLetterIndex = 0
                    score = 0
                    showAlert = false
                }
                .padding()
            }
        }
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}


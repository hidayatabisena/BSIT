//
//  HurufView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 01/04/23.
//

import SwiftUI

import SwiftUI

struct HurufView: View {
    @State private var currentCharacter: String = ""
    @State private var score: Int = 0
    @State private var answer: String = ""
    @State private var isGameEnded: Bool = false
    
    var body: some View {
        VStack {
            Text("Skor: \(score)")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            Text(currentCharacter)
                .font(.largeTitle)
                .foregroundColor(.gray)
                .padding()
            
            TextField("Jawaban", text: $answer)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Periksa") {
                if answer.lowercased() == currentCharacter.lowercased() {
                    score += 1
                }
                if score >= 10 {
                    isGameEnded = true
                } else {
                    currentCharacter = String("ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement()!)
                    answer = ""
                }
            }
            .disabled(answer.isEmpty)
            .padding()
            
            Button("Mulai") {
                currentCharacter = String("ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement()!)
                score = 0
            }
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(10)
            .padding()
            
            .alert(isPresented: $isGameEnded) {
                Alert(
                    title: Text("Permainan Berakhir"),
                    message: Text("Skor kamu adalah \(score)"),
                    dismissButton: .default(Text("Keluar"))
                )
            }
        }
    }
}


struct HurufView_Previews: PreviewProvider {
    static var previews: some View {
        HurufView()
    }
}

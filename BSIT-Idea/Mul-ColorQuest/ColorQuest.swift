//
//  ColorQuest.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import SwiftUI

struct ColorQuest: View {
    
    let colors = ["Merah", "Kuning", "Hijau", "Biru"]
    @State var score = 0
    @State var currentColor = ""
    @State var selectedColors = Set<String>()
    @State var isGameEnded = false
    @State var showAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if isGameEnded {
                    Text("Permainan selesai!")
                        .font(.largeTitle)
                    
                    Button("Mulai Lagi") {
                        newGame()
                    }
                } else {
                    Text("Skor: \(score)")
                        .font(.largeTitle)
                    
                    
                    Rectangle()
                        .fill(getColor(currentColor))
                        .frame(width: 200, height: 200)
                    
                    HStack {
                        ForEach(colors, id: \.self) { color in
                            Rectangle()
                                .fill(getColor(color))
                                .frame(width: 50, height: 50)
                                .gesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            didTapColor(color)
                                        }
                                )
                        }
                    }
                    .padding(.vertical)
                    
                    Button("Reset Permainan") {
                        newGame()
                    }
                    .disabled(selectedColors.isEmpty == true)
                    .buttonStyle(.borderedProminent)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Oops warna salah!"),
                    message: Text("Kamu harus memilih warna \(currentColor)"),
                    dismissButton: .default(Text("Coba Lagi"))
                )
            }
            .onAppear {
                newGame()
            }
        }
    }
    
    func newGame() {
        score = 0
        selectedColors.removeAll()
        currentColor = colors.randomElement()!
        isGameEnded = false
    }
    
    func getColor(_ color: String) -> Color {
        switch color {
        case "Merah":
            return .red
        case "Kuning":
            return .yellow
        case "Hijau":
            return .green
        case "Biru":
            return .blue
        default:
            return .clear
        }
    }
    
    func didTapColor(_ color: String) {
        if selectedColors.contains(color) {
            selectedColors.remove(color)
        } else {
            selectedColors.insert(color)
        }
        
        if selectedColors.contains(currentColor) {
            score += 1
            selectedColors.removeAll()
            currentColor = colors.randomElement()!
            
            if score == 10 {
                isGameEnded = true
            }
        } else if selectedColors.count == 3 {
            selectedColors.removeAll()
            showAlert = true
        }
    }
}

struct ColorQuest_Previews: PreviewProvider {
    static var previews: some View {
        ColorQuest()
    }
}

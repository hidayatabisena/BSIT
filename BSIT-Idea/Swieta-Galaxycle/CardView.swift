//
//  CardView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import SwiftUI

// MARK: - Card Model
struct Card {
    let title: String
    let imageName: String
    let description: String
}

// MARK: - Card View
struct CardView: View {
    // MARK: - PROPERTIES
    var cards: [Card] = [
        Card(title: "Matahari", imageName: "sun.max.fill", description: "Matahari adalah bintang di pusat tata surya yang menyediakan energi untuk kehidupan di Bumi."),
        Card(title: "Bumi", imageName: "globe.asia.australia.fill", description: "Bumi adalah planet ketiga dari Matahari dan satu-satunya objek astronomi yang diketahui memiliki kehidupan."),
        Card(title: "Bulan", imageName: "moon.stars.circle.fill", description: "Bulan adalah satelit alami Bumi yang mempengaruhi pasang surut dan memiliki pengaruh signifikan pada kehidupan di Bumi.")
    ]
    
    @State var currentIndex: Int = 0
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            
            ForEach(cards.indices) { index in
                if index == currentIndex {
                    CardRow(card: cards[index])
                    // .animation(.spring())
                        .animation(Animation.spring(), value: UUID())
                        .onTapGesture {
                            if currentIndex == cards.count - 1 {
                                currentIndex = 0
                            } else {
                                currentIndex += 1
                            }
                        }
                    
                }
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

// MARK: - Card Row
struct CardRow: View {
    var card: Card
    var onRemove: ((_ card: Card) -> Void)? = nil
    
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        VStack {
            Image(systemName: card.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.yellow)
            
            Text(card.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
                .foregroundColor(.white)
            
            Text(card.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
        }
        .padding()
        .background(.indigo)
        .cornerRadius(10)
        .shadow(radius: 5)
        .offset(dragOffset)
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    dragOffset = gesture.translation
                })
                .onEnded({ gesture in
                    if abs(dragOffset.width) > 100 {
                        onRemove?(card)
                    } else {
                        dragOffset = .zero
                    }
                })
        )
    }
}

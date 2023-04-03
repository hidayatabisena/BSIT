//
//  HomeView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 01/04/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Belajar Mengenal Huruf dan Angka")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.top, 80)
                    
                    Spacer()
                    
                    HStack(spacing: 30) {
                        NavigationLink(destination: HurufView()) {
                            VStack {
                                Image(systemName: "textformat.abc")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 10)
                                
                                Text("Huruf")
                                    .font(.headline)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        NavigationLink(destination: AngkaView()) {
                            VStack {
                                Image(systemName: "number.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 10)
                                
                                Text("Angka")
                                    .font(.headline)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.bottom, 120)
                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


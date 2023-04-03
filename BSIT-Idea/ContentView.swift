//
//  ContentView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 01/04/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                Text("BSIT App Idea Gen-2")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .padding(.top, 40)
        
                VStack {
                    NavigationLink(destination: HomeView()) {
                        Text("Ide Susi")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: PlayAudioFunny()) {
                        Text("Ide Yusuf")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: BillListView()) {
                        Text("Ide Faldi")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: ColorQuest()) {
                        Text("Ide Mul")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: LocationView()) {
                        Text("Ide Rizka")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: PrayerView()) {
                        Text("Ide Zizi")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: TuneMateView()) {
                        Text("Ide Bryan")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: EventListView()) {
                        Text("Ide Nanda")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: CardView()) {
                        Text("Ide Swieta")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: RecipeView()) {
                        Text("Ide Dyah")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
            }
            .background(LinearGradient(colors: [Color.purple, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea())
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

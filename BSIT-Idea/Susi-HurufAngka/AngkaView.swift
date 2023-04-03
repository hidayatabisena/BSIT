//
//  AngkaView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 01/04/23.
//

import AVFoundation
import SwiftUI

struct AngkaView: View {
    let systemNames = ["star.fill", "heart.fill", "circle.fill", "square.fill", "triangle.fill", "flag.checkered.circle.fill", "l.joystick.tilt.left.fill", "circle.grid.cross.right.filled"]
    
    @State var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        NavigationStack {
            ScrollView() {
                VStack(spacing: 30) {
                    ForEach(0..<26) { i in
                        HStack {
                            Image(systemName: "\(i + 1).circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.blue)
                            
                            Text(String(i + 65))
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                            
                            Image(systemName: systemNames.randomElement() ?? "star.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color(hue: Double.random(in: 0...1), saturation: Double.random(in: 0.5...1), brightness: 1))
                                .frame(width: 150, height: 120)
                                .cornerRadius(8)
                            
                            Text(String(i + 97))
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                
                            }) {
                                Image(systemName: "speaker.wave.2.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.blue)
                                    .frame(width: 30, height: 30)
                                    .onTapGesture {
                                        playAudio()
                                    }

                            }
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Bentuk dan Angka")
        }
        

    }
    
    func playAudio() {
        guard let url = Bundle.main.url(forResource: "sample-3s", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }

}

struct AngkaView_Previews: PreviewProvider {
    static var previews: some View {
        AngkaView()
    }
}

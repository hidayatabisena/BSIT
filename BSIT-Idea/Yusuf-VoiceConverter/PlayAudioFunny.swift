//
//  PlayAudioFunny.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 01/04/23.
//

import SwiftUI
import AVFoundation

struct PlayAudioFunny: View {
    @State private var isPlaying = false
    @State var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [Color.pink, Color.orange]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                isPlaying.toggle()
                if isPlaying {
                    playAudio()
                } else {
                    audioPlayer?.stop()
                }
            }, label: {
                Text(isPlaying ? "Stop Audio Playback" : "Start Audio Playback")
                    .foregroundColor(.white)
                    .padding()
                    .background(isPlaying ? Color.red : Color.green)
                    .cornerRadius(10)
            })
        }
    }
    
    func playAudio() {
        guard let url = Bundle.main.url(forResource: "obama", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func playAudio2() {
        guard let url = Bundle.main.url(
            forResource: "obama",
            withExtension: "mp3")
        else { return }
        
        do {
            // Set up audio file and player
            let audioFile = try AVAudioFile(forReading: url)
            let format = audioFile.processingFormat
            
            let audioLengthSample = audioFile.length
            let audioSampleRate = format.sampleRate
            let audioLengthSeconds = Double(audioLengthSample) / audioSampleRate
            
            // https://www.kodeco.com/21672160-avaudioengine-tutorial-for-ios-getting-started#toc-anchor-008
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct PlayAudioFunny_Previews: PreviewProvider {
    static var previews: some View {
        PlayAudioFunny()
    }
}

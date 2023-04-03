//
//  RecordAudioView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 01/04/23.
//

import SwiftUI
import AVFoundation

struct RecordAudioView: View {
    
    @State private var isRecording = false
    @State private var recordedAudio: AVAudioFile?
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        VStack {
            if recordedAudio == nil {
                Button(isRecording ? "Stop Recording" : "Start Recording") {
                    isRecording ? stopRecording() : startRecording()
                    isRecording.toggle()
                }
            } else {
                Button("Play Recorded Audio") {
                    playRecordedAudio()
                }
            }
        }
        .padding()
    }
    
    private func startRecording() {
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(.playAndRecord, mode: .default, options: [])
        try! session.setActive(true, options: [])
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("recordedAudio.wav")
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        audioRecorder = try! AVAudioRecorder(url: url, settings: settings)
        audioRecorder?.record()
    }
    
    private func stopRecording() {
        audioRecorder?.stop()
        recordedAudio = try! AVAudioFile(forReading: audioRecorder!.url)
        audioRecorder = nil
    }
    
    private func playRecordedAudio() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: recordedAudio!.url)
            audioPlayer?.play()
        } catch {
            print("Error playing recorded audio: \(error.localizedDescription)")
        }
    }
    
    private func playAudioFile() {
        guard let audioFileURL = Bundle.main.url(forResource: "obama", withExtension: "mp3") else {
            print("Audio file not found")
            return
        }
        
        do {
            let audioFile = try AVAudioFile(forReading: audioFileURL)
            
            // Set up audio engine and player node
            let engine = AVAudioEngine()
            let player = AVAudioPlayerNode()
            engine.attach(player)
            
            // Set up pitch effect
            let pitchEffect = AVAudioUnitTimePitch()
            pitchEffect.pitch = -700 // Adjust this value to change the pitch
            engine.attach(pitchEffect)
            
            // Connect player to pitch effect to output
            engine.connect(player, to: pitchEffect, format: audioFile.processingFormat)
            engine.connect(pitchEffect, to: engine.mainMixerNode, format: audioFile.processingFormat)
            
            // Schedule the audio file for playback
            player.scheduleFile(audioFile, at: nil, completionHandler: nil)
            
            // Start the audio engine and player
            try engine.start()
            player.play()
        } catch {
            print("Error playing audio file with funny voice effect: \(error.localizedDescription)")
        }
    }

}


struct FunnyVoiceConverter_Previews: PreviewProvider {
    static var previews: some View {
        RecordAudioView()
    }
}

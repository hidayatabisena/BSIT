//
//  WaveFormView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import SwiftUI
import AVFoundation

struct WaveformShape: Shape {
    let audioFileURL: URL
    
    func path(in rect: CGRect) -> Path {
        guard let audioFile = try? AVAudioFile(forReading: audioFileURL) else {
            return Path()
        }
        
        let sampleRate = audioFile.fileFormat.sampleRate
        let samplesPerPixel = Int(sampleRate / 100)
        let numChannels = audioFile.fileFormat.channelCount
        let frameCount = UInt32(audioFile.length)
        let buffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: frameCount)!
        try! audioFile.read(into: buffer)
        
        var points: [CGPoint] = []
        for channel in 0 ..< numChannels {
            let channelData = buffer.floatChannelData![Int(channel)]
            var x: CGFloat = 0.0
            for i in stride(from: 0, to: Int(frameCount), by: samplesPerPixel) {
                var maxAmplitude: Float = 0.0
                for j in 0 ..< samplesPerPixel {
                    let sample = channelData[i + j]
                    maxAmplitude = max(maxAmplitude, abs(sample))
                }
                let y = (1 - CGFloat(maxAmplitude)) * rect.height / 2
                points.append(CGPoint(x: x, y: y))
                x += rect.width / CGFloat(frameCount / UInt32(samplesPerPixel))
            }
        }
        
        let path = Path { path in
            path.addLines(points)
        }
        
        return path
    }
}

struct WaveformView: View {
    let audioFileURL: URL
    
    var body: some View {
        WaveformShape(audioFileURL: audioFileURL)
            .stroke(Color.blue, lineWidth: 2)
    }
}

struct WaveformView_Previews: PreviewProvider {
    static var previews: some View {
        WaveformView(audioFileURL: Bundle.main.url(forResource: "obama", withExtension: "mp3")!)
    }
}


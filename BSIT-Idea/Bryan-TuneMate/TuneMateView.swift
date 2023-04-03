//
//  TuneMateView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import SwiftUI
import AVFoundation

struct TuneMateView: View {
    // MARK: - PROPERTIES
    let genres = ["Pop", "Rock", "R&B", "Soul", "New Wave"]
    @State private var selectedGenre = "Pop"
    
    var filteredSongs: [Song] {
        allSongs.filter { $0.genre == selectedGenre }
    }
    
    @State private var albumArtURLs: [Int: URL] = [:]
    @State private var audioPlayer: AVPlayer?
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select a genre", selection: $selectedGenre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                List(filteredSongs) { song in
                    HStack {
                        
                        if let albumArtURL = albumArtURLs[song.id] {
                            AsyncImage(url: albumArtURL) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                        } else {
                            Color.gray
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(song.title)
                                .font(.headline)
                            
                            Text(song.artist)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button {
                            // self.playPreview(for: song.previewUrl)
                        } label: {
                            Image(systemName: "play.circle.fill")
                                .font(.title3)
                                .foregroundColor(.blue)
                        }
                        
                    }
                    .onAppear {
                        if albumArtURLs[song.id] == nil {
                            fetchAlbumArt(for: song)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("For You")
            .padding()
        }
    }
    
    // MARK: - Fetch Album Art
    func fetchAlbumArt(for song: Song) {
        // make HTTP request to iTunes Search API
        let searchString = "\(song.title) \(song.artist)"
        let encodedSearchString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "https://itunes.apple.com/search?term=\(encodedSearchString)&entity=song")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200 {
                do {
                    let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                    if let albumArtURLString = searchResult.results.first?.artworkUrl100,
                       let albumArtURL = URL(string: albumArtURLString) {
                        DispatchQueue.main.async {
                            // update dictionary with album art URL for this song
                            albumArtURLs[song.id] = albumArtURL
                        }
                    }
                } catch {
                    print("Error decoding search result: \(error)")
                }
            }
        }.resume()
    }
    
    // MARK: - Play PreviewURL Music
    func playPreview(for song: Song) {
        // make HTTP request to iTunes Search API
        let searchString = "\(song.title) \(song.artist)"
        let encodedSearchString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "https://itunes.apple.com/search?term=\(encodedSearchString)&entity=song")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200 {
                do {
                    let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                    if let previewURLString = searchResult.results.first?.previewUrl,
                       let previewURL = URL(string: previewURLString) {
                        DispatchQueue.main.async {
                            // play audio from preview URL
                            audioPlayer = AVPlayer(url: previewURL)
                            audioPlayer?.play()
                        }
                    }
                } catch {
                    print("Error decoding search result: \(error)")
                }
            }
        }.resume()
    }
}

// MARK: - PREVIEW
struct TuneMateView_Previews: PreviewProvider {
    static var previews: some View {
        TuneMateView()
    }
}

// MARK: - Mapping Model
struct Song: Identifiable {
    var id: Int
    var title: String
    var artist: String
    var genre: String
    // var previewUrl: String
}

// MARK: - Feeding Data All Song
//let allSongs = [
//    Song(id: 1, title: "Shallow", artist: "Lady Gaga", genre: "Pop", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/bf/42/df/bf42dfa1-1445-5a5a-64dd-eb0d9d4962f5/mzaf_788334498167547444.plus.aac.p.m4a"),
//    Song(id: 2, title: "Thinking Out Loud", artist: "Ed Sheeran", genre: "Pop", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/bf/42/df/bf42dfa1-1445-5a5a-64dd-eb0d9d4962f5/mzaf_788334498167547444.plus.aac.p.m4a"),
//    Song(id: 3, title: "Stairway to Heaven", artist: "Led Zeppelin", genre: "Rock", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/bf/42/df/bf42dfa1-1445-5a5a-64dd-eb0d9d4962f5/mzaf_788334498167547444.plus.aac.p.m4a"),
//    Song(id: 4, title: "Bohemian Rhapsody", artist: "Queen", genre: "Rock", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/bf/42/df/bf42dfa1-1445-5a5a-64dd-eb0d9d4962f5/mzaf_788334498167547444.plus.aac.p.m4a"),
//    Song(id: 5, title: "Uptown Funk", artist: "Mark Ronson ft. Bruno Mars", genre: "R&B", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/bf/42/df/bf42dfa1-1445-5a5a-64dd-eb0d9d4962f5/mzaf_788334498167547444.plus.aac.p.m4a"),
//    Song(id: 6, title: "I Will Always Love You", artist: "Whitney Houston", genre: "R&B", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/bf/42/df/bf42dfa1-1445-5a5a-64dd-eb0d9d4962f5/mzaf_788334498167547444.plus.aac.p.m4a"),
//    Song(id: 7, title: "All of Me", artist: "John Legend", genre: "Soul", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/bf/42/df/bf42dfa1-1445-5a5a-64dd-eb0d9d4962f5/mzaf_788334498167547444.plus.aac.p.m4a"),
//    Song(id: 8, title: "A Change Is Gonna Come", artist: "Sam Cooke", genre: "Soul", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/bf/42/df/bf42dfa1-1445-5a5a-64dd-eb0d9d4962f5/mzaf_788334498167547444.plus.aac.p.m4a"),
//    Song(id: 9, title: "Love Shack", artist: "The B-52's", genre: "New Wave", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/bf/42/df/bf42dfa1-1445-5a5a-64dd-eb0d9d4962f5/mzaf_788334498167547444.plus.aac.p.m4a"),
//    Song(id: 10, title: "Just Like Heaven", artist: "The Cure", genre: "New Wave", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/bf/42/df/bf42dfa1-1445-5a5a-64dd-eb0d9d4962f5/mzaf_788334498167547444.plus.aac.p.m4a")
//]

let allSongs = [
    Song(id: 1, title: "Shallow", artist: "Lady Gaga", genre: "Pop"),
    Song(id: 2, title: "Thinking Out Loud", artist: "Ed Sheeran", genre: "Pop"),
    Song(id: 3, title: "Stairway to Heaven", artist: "Led Zeppelin", genre: "Rock"),
    Song(id: 4, title: "Bohemian Rhapsody", artist: "Queen", genre: "Rock"),
    Song(id: 5, title: "Uptown Funk", artist: "Mark Ronson ft. Bruno Mars", genre: "R&B"),
    Song(id: 6, title: "I Will Always Love You", artist: "Whitney Houston", genre: "R&B"),
    Song(id: 7, title: "All of Me", artist: "John Legend", genre: "Soul"),
    Song(id: 8, title: "A Change Is Gonna Come", artist: "Sam Cooke", genre: "Soul"),
    Song(id: 9, title: "Love Shack", artist: "The B-52's", genre: "New Wave"),
    Song(id: 10, title: "Just Like Heaven", artist: "The Cure", genre: "New Wave")
]

// MARK: - Search Result iTunes API
struct SearchResult: Codable {
    let results: [SearchResultItem]
}

struct SearchResultItem: Codable {
    let artworkUrl100: String
    let previewUrl: String?
}

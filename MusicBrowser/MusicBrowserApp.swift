//
//  MusicBrowserApp.swift
//  MusicBrowser
//
//  Created by James Sartelle on 5/12/21.
//

import SwiftUI
import MediaPlayer

@main
struct MusicBrowserApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ModelData())
        }
    }
}

extension MPMediaItem {
    var displayArtist: String? {
        self.albumArtist ?? self.artist
    }
}

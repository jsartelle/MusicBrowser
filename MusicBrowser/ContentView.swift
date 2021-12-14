//
//  ContentView.swift
//  MusicBrowser
//
//  Created by James Sartelle on 5/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var currentSource: Source?
    
    enum Source: String, CaseIterable, Identifiable {
        case artists, albums, genres, songs
        var id: Source { self }
    }
    
    var body: some View {
        NavigationView {
            List(selection: $currentSource) {
                Section(header: Text("Pinned")) {
                    
                }
                
                Section(header: Text("Library")) {
                    NavigationLink(destination: EmptyView()) {
                        Label("Artists", systemImage: "music.mic")
                    }
                    
                    NavigationLink(destination: AlbumGrid()) {
                        Label("Albums", systemImage: "square.stack")
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        Label("Genres", systemImage: "guitars")
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        Label("Songs", systemImage: "music.note")
                    }
                }
                
                Section(header: Text("Playlists")) {
                    
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Library")
        }
        .accentColor(.pink)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
            .previewLayout(.fixed(width: 700, height: 500))
    }
}

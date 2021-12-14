//
//  AlbumGrid.swift
//  MusicBrowser
//
//  Created by James Sartelle on 5/12/21.
//

import SwiftUI
import MediaPlayer

struct AlbumGrid: View {
    @EnvironmentObject var modelData: ModelData
    
    // TODO: hookup search
    
    let spacing: CGFloat = 20
    let gridLayout = [GridItem(.adaptive(minimum: 150, maximum: 250), spacing: 20)]
    
    var body: some View {
        // TODO: alphabetical index
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: spacing) {
                ForEach(modelData.albums, id: \.self) { album in
                    NavigationLink(destination: AlbumDetail(album: album)) {
                        AlbumGridItem(album: album)
                    }
                    .tag(album)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(spacing)
        }
        .navigationTitle("Albums")
        .navigationBarItems(trailing: Button(action: {
            
        }) {
            Image(systemName: "magnifyingglass")
        })
    }
}

struct AlbumGrid_Previews: PreviewProvider {
    static var previews: some View {
        AlbumGrid()
            .environmentObject(ModelData())
            .previewLayout(.fixed(width: 700, height: 500))
    }
}

//
//  AlbumGridItem.swift
//  MusicBrowser
//
//  Created by James Sartelle on 5/12/21.
//

import SwiftUI
import MediaPlayer

struct AlbumGridItem: View {
    var album: MPMediaItemCollection
    
    var body: some View {
        if let item = album.representativeItem {
            VStack {
                MediaItemThumbnail(item: item)
                
                if let title = item.albumTitle {
                    Text(title)
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }
                
                if let artist = item.displayArtist {
                    Text(artist)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
        }
    }
}

struct AlbumGridItem_Previews: PreviewProvider {
    static var previews: some View {
        AlbumGridItem(album: ModelData().albums[0])
            .previewLayout(.fixed(width: 250, height: 350))
    }
}

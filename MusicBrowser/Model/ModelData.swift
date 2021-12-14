//
//  ModelData.swift
//  MusicBrowser
//
//  Created by James Sartelle on 5/13/21.
//

import SwiftUI
import Combine
import MediaPlayer

final class ModelData: ObservableObject {
    @Published var albums = getAlbums()
    
    struct AlbumGroup: Identifiable {
        var key: String
        var albums: [MPMediaItemCollection]
        
        var id: String { key }
    }
}

func getAlbums() -> [MPMediaItemCollection] {
    let query = MPMediaQuery.albums()
    
//    query.addFilterPredicate(
//        MPMediaPropertyPredicate(value: "Charli", forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: .contains)
//    )
    
    guard let albums = query.collections else {
        return []
    }
    
    // TODO: sorting options
    return albums.sorted {
        guard let artist0 = $0.representativeItem?.displayArtist else {
            return false
        }
        
        guard let artist1 = $1.representativeItem?.displayArtist else {
            return true
        }
        
        return artist0.localizedCaseInsensitiveCompare(artist1) == .orderedAscending
    }
}

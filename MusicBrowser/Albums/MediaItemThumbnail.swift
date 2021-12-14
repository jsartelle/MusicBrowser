//
//  MediaItemThumbnail.swift
//  MusicBrowser
//
//  Created by James Sartelle on 5/18/21.
//

import SwiftUI
import MediaPlayer

struct MediaItemThumbnail: View {
    var item: MPMediaItem
    var imageSize: CGSize = CGSize(width: 250, height: 250)
    
    var body: some View {
        if let artwork = item.artwork?.image(at: imageSize) {
            Image(uiImage: artwork)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(20)
            
        } else {
            Rectangle()
                .foregroundColor(.gray)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    GeometryReader { geometry in
                        Image(systemName: "square.stack")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.all, geometry.size.width / 4)
                            .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                            .foregroundColor(.white)
                    }
                )
                .cornerRadius(20)
        }

    }
}

struct MediaItemThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        MediaItemThumbnail(item: ModelData().albums[50].representativeItem!)
            .previewLayout(.fixed(width: 250, height: 250))
    }
}

//
//  AlbumDetail.swift
//  MusicBrowser
//
//  Created by James Sartelle on 5/12/21.
//

import SwiftUI
import MediaPlayer

struct AlbumDetail: View {
    var album: MPMediaItemCollection
    
    let spacing: CGFloat = 25
    
    func formatTrackDuration(_ seconds: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = seconds >= 3600 ? [.hour, .minute, .second] : [.minute, .second]
        formatter.zeroFormattingBehavior = [ .pad ]
        return formatter.string(from: seconds) ?? ""
    }
    
    func formatAlbumDuration(_ seconds: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = seconds >= 3600 ? [.hour, .minute, .second] : [.minute, .second]
        formatter.maximumUnitCount = seconds >= 3600 ? 2 : 1
        return formatter.string(from: seconds) ?? ""
    }
    
    func formatReleaseDate(_ releaseDate: Date?) -> String {
        guard let releaseDate = releaseDate else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: releaseDate)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                if let item = album.representativeItem {
                    if let artwork = item.artwork?.image(
                        at: CGSize(width: geometry.size.width, height: geometry.size.height)
                    ) {
                        Image(uiImage: artwork)
                            .resizable()
                            .blur(radius: 75)
                            .scaleEffect(1.15)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .bottom, spacing: spacing) {
                            // TODO: click on album art to zoom
                            MediaItemThumbnail(item: item, imageSize: CGSize(width: 150, height: 150))
                            
                            VStack(alignment: .leading) {
                                if let title = item.albumTitle {
                                    Text(title)
                                        .font(.headline)
                                }
                                
                                if let artist = item.displayArtist {
                                    Text(artist)
                                        .font(.subheadline)
                                        .opacity(2/3)
                                }
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                if let genre = item.genre {
                                    Text(genre)
                                        .font(.subheadline)
                                        .opacity(2/3)
                                }
                                
                                if let releaseDate = item.releaseDate {
                                    Text(formatReleaseDate(releaseDate))
                                        .font(.subheadline)
                                        .opacity(2/3)
                                }
                                
                                let trackCount = "\(album.count) track\(album.count > 1 ? "s" : "")"
                                let totalDuration = album.items.reduce(0) {
                                    $0 + $1.playbackDuration
                                }
                                
                                Text("\(trackCount) • \(formatAlbumDuration(totalDuration))")
                                    .font(.subheadline)
                                    .opacity(2/3)
                            }
                            .preferredColorScheme(.none)
                        }
                        .padding(.horizontal, spacing)
                        .offset(y: 55)
                        .zIndex(1)
                        
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 0) {
                                ForEach(album.items, id: \.persistentID) { track in
                                    HStack(alignment: .top) {
                                        if let trackNumber = track.albumTrackNumber {
                                            Text(String(format: "%02d", trackNumber))
                                                .opacity(2/3)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 2.5) {
                                            if let title = track.title {
                                                Text(title)
                                            }
                                            
                                            if let artist = track.artist,
                                               let albumArtist = track.albumArtist,
                                               artist != albumArtist {
                                                Text(artist)
                                                    .font(.caption)
                                                    .opacity(2/3)
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        if let duration = track.playbackDuration {
                                            Text(formatTrackDuration(duration))
                                                .opacity(2/3)
                                        }
                                    }
                                    .padding(.horizontal, spacing)
                                    .padding(.vertical, 10)
                                    .frame(width: geometry.size.width, alignment: .leading)
                                    .lineLimit(2)
                                    
                                    Divider()
                                        .background(Color.white)
                                        .opacity(0.5)
                                        .padding(.horizontal, spacing)
                                }
                            }
                        }
                        .padding(.top, 65)
                        .background(Color(white: 0, opacity: 0.5))
                    }
                    .foregroundColor(.white)
                }
            }
            .navigationTitle(album.representativeItem?.albumTitle ?? "Album")
            .background(Color.gray)
        }
    }
    
    // https://filipmolcik.com/navigationview-dynamic-background-color-in-swiftui/
//    struct NavigationBarModifier: ViewModifier {
//        init() {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithTransparentBackground()
//            appearance.backgroundColor = .clear
//            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//            UINavigationBar.appearance().standardAppearance = appearance
//            UINavigationBar.appearance().compactAppearance = appearance
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//            UINavigationBar.appearance().tintColor = .white
//        }
//
//        func body(content: Content) -> some View {
//            content
//        }
//    }
}

struct AlbumDetail_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetail(album: ModelData().albums[286])
            .previewLayout(.fixed(width: 700, height: 500))
    }
}

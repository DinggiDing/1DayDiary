//
//  MediaCell.swift
//  Diary
//
//  Created by 성재 on 3/8/24.
//

import SwiftUI
import ExyteMediaPicker
import AVFoundation
import _AVKit_SwiftUI

struct MediaCell: View {

    @StateObject var viewModel: MediaCellViewModel
    @Binding var url_array : [URL]

    var body: some View {
        GeometryReader { g in
            VStack {
                if let url = viewModel.imageUrl {
                    AsyncImage(url: url) { phase in
                        if case let .success(image) = phase {
                            image
                                .resizable()
                                .scaledToFill()
                                .onAppear {
                                    url_array.append(viewModel.imageUrl!)
//                                    
                                    /// 중복 제거
                                    url_array = removeDuplicate(url_array)
                                }
                        }
                    }
                }
//                else if let player = viewModel.player {
//                    VideoPlayer(player: player).onTapGesture {
//                        viewModel.togglePlay()
//                    }
//                }
                else {
                    ProgressView()
                }
            }
            .frame(width: g.size.width, height: g.size.height)
            .clipped()
            
        }
        .task {
            await viewModel.onStart()
        }
        .onDisappear {
            viewModel.onStop()
        }
    }
    func removeDuplicate (_ array: [URL]) -> [URL] {
        var removedArray = [URL]()
        for i in array {
            if removedArray.contains(i) == false {
                removedArray.append(i)
            }
        }
        return removedArray
    }
}

final class MediaCellViewModel: ObservableObject {

    let media: Media

    @Published var imageUrl: URL? = nil
    @Published var player: AVPlayer? = nil

    private var isPlaying = false

    init(media: Media) {
        self.media = media
    }

    func onStart() async {
        guard imageUrl == nil || player == nil else { return }

        let url = await media.getURL()
        guard let url = url else { return }

        DispatchQueue.main.async {
            switch self.media.type {
            case .image:
                self.imageUrl = url
            case .video:
                self.player = AVPlayer(url: url)
            }
        }
    }

//    func togglePlay() {
//        if isPlaying {
//            player?.pause()
//        } else {
//            player?.play()
//        }
//        isPlaying = !isPlaying
//    }

    func onStop() {
        imageUrl = nil
        player = nil
        isPlaying = false
    }
}


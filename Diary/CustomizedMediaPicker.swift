//
//  CustomizedMediaPicker.swift
//  Diary
//
//  Created by 성재 on 3/8/24.
//

import Foundation
import SwiftUI
import ExyteMediaPicker

struct CustomizedMediaPicker: View {

    @Binding var isPresented: Bool
    @Binding var medias: [Media]

    @State private var albums: [Album] = []

    @State private var mediaPickerMode = MediaPickerMode.photos
    @State private var selectedAlbum: Album?
    @State private var currentFullscreenMedia: Media?
    @State private var showAlbumsDropDown: Bool = false
//    @State private var videoIsBeingRecorded: Bool = false

    let maxCount: Int = 3

    var body: some View {
        MediaPicker(
            isPresented: $isPresented,
            onChange: {
                medias = $0
            },
            albumSelectionBuilder: { _, albumSelectionView, _ in
                VStack {
                    headerView
                    albumSelectionView
                    Spacer()
                    footerView
                        .background(Color.white)
                }
                .background(Color.white)
            },
            cameraSelectionBuilder: { addMoreClosure, cancelClosure, cameraSelectionView in
                VStack {
                    HStack {
                        Spacer()
                        Button("Done", action: { isPresented = false })
                            .greenButtonStyle()
                    }
                    .padding()
                    cameraSelectionView
                    HStack {
                        Button("Cancel", action: cancelClosure)
                            .greenButtonStyle()
                        Spacer()
                        Button(action: addMoreClosure) {
                            Text("Take more photos")
                                .greenButtonStyle()
                        }
                    }
                    .padding()
                }
                .background(Color.black)
            },
//            cameraViewBuilder: { cameraSheetView, cancelClosure, showPreviewClosure, takePhotoClosure, startVideoCaptureClosure, stopVideoCaptureClosure, _, _ in
//                cameraSheetView
//                    .overlay(alignment: .topLeading) {
//                        HStack {
//                            Button("Cancel") { cancelClosure() }
//                                .foregroundColor(Color("subpoint"))
//                            Spacer()
//                            Button("Done") { showPreviewClosure() }
//                                .foregroundColor(Color("subpoint"))
//                        }
//                        .padding()
//                        .padding(.top, 25)
//
//                    }
//                    .overlay(alignment: .bottom) {
//                        HStack {
//                            Button("Take photo") { takePhotoClosure() }
//                                .greenButtonStyle()
////                            Button(videoIsBeingRecorded ? "Stop video capture" : "Capture video") {
////                                videoIsBeingRecorded ? stopVideoCaptureClosure() : startVideoCaptureClosure()
////                                videoIsBeingRecorded.toggle()
////                            }
////                            .greenButtonStyle()
//                        }
//                        .padding()
//                        .padding(.bottom, 25)
//                    }
//            }
            cameraViewBuilder: { cameraSheetView, cancelClosure, showPreviewClosure, takePhotoClosure, _, _, _, _ in
                cameraSheetView
                    .overlay(alignment: .topLeading) {
                        HStack {
                            Button("Cancel") { cancelClosure() }
                                .foregroundColor(Color("subpoint"))
                            Spacer()
                            Button("Done") { showPreviewClosure() }
                                .foregroundColor(Color("subpoint"))
                        }
                        .padding()
                        .padding(.top, 25)

                    }
                    .overlay(alignment: .bottom) {
                        HStack {
                            Button("Take photo") { takePhotoClosure() }
                                .greenButtonStyle()
//                            Button(videoIsBeingRecorded ? "Stop video capture" : "Capture video") {
//                                videoIsBeingRecorded ? stopVideoCaptureClosure() : startVideoCaptureClosure()
//                                videoIsBeingRecorded.toggle()
//                            }
//                            .greenButtonStyle()
                        }
                        .padding()
                        .padding(.bottom, 25)
                    }
            }
        )
//        .showLiveCameraCell()
        .mediaSelectionType(.photo)
        .albums($albums)
        .pickerMode($mediaPickerMode)
        .currentFullscreenMedia($currentFullscreenMedia)
        .mediaSelectionStyle(.count)
        .mediaSelectionLimit(maxCount)
        .mediaPickerTheme(
            main: .init(
                albumSelectionBackground: .white,
                fullscreenPhotoBackground: .white
            ),
            selection: .init(
                emptyTint: .black,
                emptyBackground: .black.opacity(0.25),
                selectedTint: Color("subpoint"),
                fullscreenTint: .black
            )
        )
        .overlay(alignment: .topLeading) {
            if showAlbumsDropDown {
                albumsDropdown
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(5)
            }
        }
        .background(Color.white)
        .foregroundColor(.black)
    }

    var headerView: some View {
        HStack {
            HStack {
                Text(selectedAlbum?.title ?? "Recents")
                Image(systemName: "chevron.down")
                    .rotationEffect(Angle(radians: showAlbumsDropDown ? .pi : 0))
            }
            .onTapGesture {
                withAnimation {
                    showAlbumsDropDown.toggle()
                }
            }

            Spacer()

            Text("\(medias.count) out of \(maxCount) selected")
        }
        .padding()
    }

    var footerView: some View {
        HStack {
            Text("닫기")
                .foregroundColor(.black2)
                .padding()
                .background {
                    Color.white.opacity(0.2)
                        .cornerRadius(6)
                }
                .onTapGesture {
                    isPresented = false
                }

            Spacer(minLength: 70)

            Button {
                isPresented = false
            } label: {
                HStack {
                    Text("Add")
                        .foregroundStyle(Color.white)

                    Text("\(medias.count)")
                        .padding(6)
                        .background(Color.white)
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity)
            }
            .greenButtonStyle()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }

    var albumsDropdown: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(albums) { album in
                    Button(album.title ?? "") {
                        selectedAlbum = album
                        mediaPickerMode = .album(album)
                        showAlbumsDropDown = false
                    }.foregroundStyle(.black)
                }
            }
            .padding(15)
        }
        .frame(maxHeight: 300)
    }
}

extension View {
    func greenButtonStyle() -> some View {
        self.font(.headline)
            .foregroundColor(.subpoint)
            .padding()
            .background {
                Color("subpoint")
                    .cornerRadius(16)
            }
    }
}

//
//  MemoryDetailView.swift
//  Diary
//
//  Created by 성재 on 5/2/24.
//

import SwiftUI
import Kingfisher

struct MemoryDetailView: View {
    
    let columns = [GridItem(.flexible(), spacing: 1)]
    @State private var image_ratio: Float = 0.8
    @State private var image_height: Int = 150
    @State private var image_tap = false
    @State private var image_url = ""

    
    var db: DB_core
    @State private var text_alignment: TextAlignment = .leading
    @State private var text_alignmentview: Alignment = .leading
    @State private var isHiding: Bool = false
    
    @AppStorage("MyfontValue") private var fontvalue: String = "Arita-buri-Medium_OTF"
    @AppStorage("MyTitlefontValue") private var titlefontvalue: String = "Arita-buri-Bold_OTF"

    @Environment(\.dismiss) var dismiss
    @Environment(\.locale) var locale: Locale

    
    init(db: DB_core) {
        self.db = db
    }
    
    var body: some View {
        VStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        HStack(spacing: 18) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .foregroundColor(Color("gray6"))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 5, height: 5)
                            HStack {
                                HStack(spacing: 5) {
                                    Text(db.date!, format: .dateTime.day(.twoDigits).month(.twoDigits))
                                        .font(Font.SUIT_Regular(locale: locale))
                                        .foregroundStyle(Color("gray3"))
                                    
                                }
                            }
                            Spacer()
                        }.padding(.bottom, 12)
                        
                        HStack {
                            Spacer()
                            Text(db.title ?? "")
                                .font(.custom(titlefontvalue, size: 20))
                                .frame(width: 280, alignment: text_alignmentview)
                                .accentColor(.gray)
                            Spacer()
    
                        }

                        if !db.image.isEmpty {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: columns, spacing: 10) {
                                    ForEach(db.image, id: \.self) { images in
                                        KFImage.url(images)
                                            .resizable()
                                            .aspectRatio(CGFloat(image_ratio), contentMode: .fill)
                                            .clipped()
                                            .onTapGesture {
                                                image_tap = true
                                                image_url = images.absoluteString
                                            }
                                            .fullScreenCover(isPresented: $image_tap, content: {
                                                ImagezoomViewer(image: $image_url, viewerShown: $image_tap)
                                            })
                                    }
                                }
                            }.frame(height: CGFloat(image_height))
                                .padding(.leading, AppConfig.homeWidth*0.08)

                        }
                        
                        HStack {
                            Spacer()
                            ZStack {
                                VStack {
                                    Text(db.status ?? "")
                                        .contentShape(Rectangle())
                                        .font(.custom(fontvalue, size: 16))
                                        .id("Texteditor")
                                        .multilineTextAlignment(text_alignment)
                                        .lineSpacing(CGFloat(db.text_spacing))
                                        .accentColor(.black)
                                        .frame(minHeight: 40)
                                        .frame(width: 280, alignment: text_alignmentview)
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                    }.frame(width: AppConfig.homeWidth-52)
                        .padding(.bottom, 44)
                }
                .scrollIndicators(.hidden)

                    
                HStack {
                    Rectangle().frame(width: 1, alignment: .center).padding(.leading, 28)
                        .foregroundStyle(.gray5)
                    Spacer()
                }
                
            }
//            .animation(.smooth, value: isHiding)

        }
        .onAppear {
            isHiding = true
            switch db.text_align {
            case 1:
                text_alignment = .leading
                text_alignmentview = .leading
            case 2:
                text_alignment = .center
                text_alignmentview = .center

            case 3:
                text_alignment = .trailing
                text_alignmentview = .trailing

            default:
                text_alignment = .leading
                text_alignmentview = .leading

            }
        }
        .gesture(
                DragGesture(minimumDistance: 20, coordinateSpace: .global)
                  .onChanged { value in // onChanged better than onEnded for this case
                    guard value.startLocation.x < 20, // starting from left edge
                          value.translation.width > 60 else { // swiping right
                    return
                  }
                dismiss()
              }
        )
    }
}

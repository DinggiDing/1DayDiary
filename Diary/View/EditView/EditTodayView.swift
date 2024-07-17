//
//  EditTodayView.swift
//  Diary
//
//  Created by 성재 on 3/31/24.
//

import SwiftUI
import ExyteMediaPicker
import Kingfisher


struct EditTodayView: View {
    
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var db : DB_core
    
    @State private var ispopups: Int = 0
    @State private var ispopups2: Int = 0
    @State private var popups: Bool = false
    @State private var maintext_fontsize : Int = 16
    @State private var maintext_alignment : TextAlignment = .leading
    @State private var maintext_linespacing : Int = 10
    @State private var image_ratio: Float = 0.8
    @State private var image_height: Int = 150
    @State private var medias: [Media] = []

    @Binding var isPresented: Bool
    @Binding var isHiding: Bool
    var isThirdTab: Bool = false
    
    let columns = [GridItem(.flexible(), spacing: 1)]
    
    @State private var url : [URL] = []
    @State private var url2: [URL] = []
    @State private var ispresented_imgpicker: Bool = false
    @State private var alignment_imagename : String = "text.alignleft"
    
    @State private var title = ""
    @State private var maintext = ""
    
    @FocusState private var keyboardFocused: Bool
    @State private var text_alignmentview: Alignment = .leading


    @AppStorage("MyfontValue") private var fontvalue: String = "Arita-buri-Medium_OTF"
    @AppStorage("MyTitlefontValue") private var titlefontvalue: String = "Arita-buri-Bold_OTF"
    @Environment(\.locale) var locale: Locale


    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(alignment: .center, spacing: 24) {
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
                                            
                                            if ispopups != 0 {
                                                Image(systemName: Mockdata.iconImageNames[ispopups-1])
                                            }
                                            
                                            if ispopups2 != 0 {
                                                Text(Mockdata2.iconImageNames[ispopups2-1])
                                            }
                                        }
                                    }
                                    Spacer()
                                }.padding(.bottom, 12)
                                    .padding(.top, 42)
                                    .onTapGesture {
                                        popups.toggle()
                                    }
                                
                                HStack {
                                    Spacer()
                                    
                                    TextField("", text: $title, axis: .vertical)
                                        .font(.custom(titlefontvalue, size: 20))
                                        .frame(width: 280, alignment: .leading)
                                        .accentColor(.gray)
                                        .multilineTextAlignment(maintext_alignment)
                                        .id("textda")
                                    
                                    /// maxLength 설정
                                        .onChange(of: title) { _ in
                                            proxy.scrollTo("textda", anchor: .bottom)
                                            title = String(title.prefix(20))
                                        }
                                    
                                    Spacer()
                                }
                                                                
                                if !medias.isEmpty {
                                    ScrollView(.horizontal) {
                                        LazyHGrid(rows: columns, spacing: 10) {
                                            ForEach(medias) { media in
                                                MediaCell(viewModel: MediaCellViewModel(media: media), url_array: $url2)
                                                    .aspectRatio(CGFloat(image_ratio), contentMode: .fill)
                                            }
                                        }
                                    }.frame(height: CGFloat(image_height))
                                        .padding(.leading, AppConfig.homeWidth*0.08)
                                        .onTapGesture {
                                            if image_ratio == 0.8 {
                                                image_ratio = 1.0
                                                image_height = 200
                                            } else {
                                                image_ratio = 0.8
                                                image_height = 150
                                            }
                                        }
                                } else {
                                    if !url.isEmpty {
                                        ScrollView(.horizontal) {
                                            LazyHGrid(rows: columns, spacing: 10) {
                                                ForEach(url, id: \.self) { ur in
                                                    KFImage(ur)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(height: CGFloat(image_height))
                                                        .clipped()
                                                }
                                            }.frame(height: CGFloat(image_height))

                                        }.frame(height: CGFloat(image_height))
                                            .padding(.leading, AppConfig.homeWidth*0.08)
                                            .onTapGesture {
                                                if image_ratio == 0.8 {
                                                    image_ratio = 1.0
                                                    image_height = 200
                                                } else {
                                                    image_ratio = 0.8
                                                    image_height = 150
                                                }
                                            }
                                    }
                                }
                                
                                HStack {
                                    Spacer()
                                    ZStack {
                                        TextEditor(text: $maintext)
                                            .contentShape(Rectangle())
                                            .font(.custom(fontvalue, size: CGFloat(maintext_fontsize)))
                                            .frame(width: 280, alignment: .leading)
                                            .multilineTextAlignment(maintext_alignment)
                                            .frame(minHeight: 300)
                                            .lineSpacing(CGFloat(maintext_linespacing))
                                            .accentColor(.black)
                                            .id("texteditorda")
                                            .focused($keyboardFocused)
                                            .onTapGesture {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    keyboardFocused = true
                                                }
                                            }
                                        
                                        /// typing focus scroll
                                            .onChange(of: maintext) { _ in
                                                proxy.scrollTo("texteditorda", anchor: .bottom)
                                            }
        
                                        if maintext.isEmpty {
                                            VStack {
                                                Text("Empty")
                                                    .font(Font.Arita_buriMedium(locale: locale))
                                                    .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                                    .foregroundStyle(Color.gray.opacity(0.55))
                                                    .padding(.top, 10)
                                                    .padding(.leading, 6)
                                                    .frame(width: 280, alignment: text_alignmentview)
                                                Spacer()
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                                
                                Spacer()
                                
                            }.frame(width: AppConfig.homeWidth-52)
                                .padding(.bottom, 44)
                        }
                        .scrollIndicators(.hidden)
                        .onTapGesture {
                            keyboardFocused = false
                        }
                    }
                    
                        
                    
                    HStack {
                        Rectangle().frame(width: 1, alignment: .center).padding(.leading, 28)
                            .foregroundStyle(.gray5)
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            updateButton(title: $title, status: $maintext, image: url2.isEmpty ? $url : $url2, db: db, emotions: $ispopups2, weathers: $ispopups, text_align: $maintext_alignment, text_spacing: $maintext_linespacing, donedone: $isPresented)
                            Spacer()
                        }
                    }.padding(.bottom, isThirdTab ? 56 : 6)
                        .ignoresSafeArea(.keyboard)
                    
                    
                }
                
                .sheet(isPresented: $popups, content: {
                    PopupBottomFirst(isPresented: $popups, ispreint: $ispopups, ispreint2: $ispopups2)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(40)
                    
                })
                
            }
            
            .onAppear {
                isHiding = true
                title = db.title!
                maintext = db.status ?? ""
                url = db.image
                ispopups = Int(db.weathers)
                ispopups2 = Int(db.emotions)
                switch db.text_align {
                case 1:
                    maintext_alignment = .leading
                    text_alignmentview = .leading

                case 2:
                    maintext_alignment = .center
                    text_alignmentview = .center

                case 3:
                    maintext_alignment = .trailing
                    text_alignmentview = .trailing

                default:
                    maintext_alignment = .leading
                    text_alignmentview = .leading

                }
                maintext_linespacing = Int(db.text_spacing)
            }
            .toolbar {
                if !isThirdTab {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Cancel") {
                            dismiss()
                        }.foregroundStyle(.black)
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    HStack {
                        Button(action: {
                            switch maintext_alignment {
                            case .leading:
                                maintext_alignment =  .center
                                alignment_imagename = "text.aligncenter"
                            case .center:
                                maintext_alignment = .trailing
                                alignment_imagename = "text.alignright"
                            case .trailing:
                                maintext_alignment = .leading
                                alignment_imagename = "text.alignleft"
                            default:
                                maintext_alignment = .leading
                                alignment_imagename = "text.alignleft"
                            }
                        }, label: {
                            Image(systemName: alignment_imagename)
                                .foregroundStyle(.accent)
                        })
                        Button(action: {
                            if maintext_linespacing == 12 {
                                maintext_linespacing = 8
                            } else {
                                maintext_linespacing = maintext_linespacing + 2
                                
                            }
                        }, label: {
                            Image(systemName: "arrow.up.and.down.text.horizontal")
                                .foregroundStyle(.accent)
                        })
                        Button(action: {
                            ispresented_imgpicker.toggle()
                        }, label: {
                            Image(systemName: "photo")
                                .foregroundStyle(.accent)
                        })
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Button(action: {
                            endTextEditing()
                        }, label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                                .foregroundStyle(.accent)
                        })

                    }
                }
            }
        }
        .fullScreenCover(isPresented: $ispresented_imgpicker, content: {
            CustomizedMediaPicker(
                isPresented: $ispresented_imgpicker,
                medias: $medias
            )
        })
        .ignoresSafeArea()

        .navigationBarHidden(true)
    }
    
}



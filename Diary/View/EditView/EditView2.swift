//
//  EditView2.swift
//  Diary
//
//  Created by 성재 on 3/8/24.
//

import SwiftUI
import ExyteMediaPicker
import TipKit
import SwiftUIIntrospect
import OneDDContent

struct EditView2: View {
    
    @Binding var isPresented: Bool
    @Binding var isHiding: Bool
    var isThirdTab: Bool = false
   
    
    // MARK: Core data에 넣을 것
    @State private var title: String = ""
    @State private var maintext: String = ""
    @State private var date: Date = Date()
    @State private var maintext_fontsize : Int = 16
    @State private var maintext_alignment : TextAlignment = .leading
    @State private var maintext_linespacing : Int = 10
    @State private var image_ratio: Float = 0.8
    @State private var image_height: Int = 150
    
    @State private var ispresented_imgpicker: Bool = false
    @State private var medias: [Media] = []
    @State private var alignment_imagename : String = "text.alignleft"
            
    let columns = [GridItem(.flexible(), spacing: 1)]
    
    @State private var popups: Bool = false
    @State private var ispopups: Int = 0
    @State private var ispopups2: Int = 0
    @State private var donedone: Bool = false
    
    @State private var popups_reflect: Bool = false
    
    @State private var url : [URL] = []
    
    private let tip = FavoriteBackyardTip()
    
    @AppStorage("MyfontValue") private var fontvalue: String = "Arita-buri-Medium_OTF"
    @AppStorage("MyTitlefontValue") private var titlefontvalue: String = "Arita-buri-Bold_OTF"
    @Environment(\.locale) var locale: Locale
    @AppStorage("reflectionDate") var reflectionDate = ""

    
    init(isPresented: Binding<Bool>, isHiding: Binding<Bool>, isThirdTab: Bool) {
        _isPresented = isPresented
        _isHiding = isHiding
        self.isThirdTab = isThirdTab
        
        UIToolbar.appearance().barTintColor = .white
    }
    
 
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
                                            Text(Date().checkDateWithinRange(date: Date.now), format: .dateTime.day(.twoDigits).month(.twoDigits))
                                                .font(Font.SUIT_Regular(locale: locale))
                                                .foregroundStyle(Color("gray3"))
                                                .popoverTip(tip)
                                            
                                            if ispopups != 0 {
                                                Image(systemName: Mockdata.iconImageNames[ispopups-1])
                                            }
                                            
                                            if ispopups2 != 0 {
                                                Text(Mockdata2.iconImageNames[ispopups2-1])
                                            }
                                            
                                            
                                        }
                                        
                                    }
                                    .onTapGesture {
                                        popups.toggle()
                                    }
                                    
                                    Spacer()
                                    if reflectionDate == Date().checkDateWithONEDDCONTENT(Date()) {
                                        
                                        HStack {
                                            Image("icon_circle")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 20, height: 20)
                                                .clipShape(Circle())
                                            
                                            Text("오늘 하루")
                                                .font(.system(size: 11, weight: .regular))
                                                .padding(.trailing, 10)
                                            
                                        }
                                        .padding(6)
                                        .background(Color.white)
                                        .clipShape(Capsule())
                                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                        .onTapGesture {
                                            withAnimation(.interpolatingSpring(mass: 1, stiffness: 170, damping: 15, initialVelocity: 0)){
                                                
                                                popups_reflect.toggle()
                                            }
                                        }
                                    }
                                }.padding(.bottom, 12)
                                    .padding(.top, 42)                                
                                    .padding(.horizontal, 26)

                                    
                                
                                HStack {
                                    Spacer()
                                    
                                    TextField(Date().formatDate(Date().checkDateWithinRange(date: Date.now), locale: locale), text: $title, axis: .vertical)
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
                                .padding(.horizontal, 26)

                                
                                if popups_reflect {
                                    InD_SwiftUIView2()
                                }
                                                                
                                if !medias.isEmpty {
                                    ScrollView(.horizontal) {
                                        LazyHGrid(rows: columns, spacing: 10) {
                                            ForEach(medias) { media in
                                                MediaCell(viewModel: MediaCellViewModel(media: media), url_array: $url)
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
                                        .padding(.horizontal, 26)

                                }
                                
                                HStack {
                                    Spacer()
                                    ZStack {
                                        TextEditor(text: $maintext)
                                            .contentShape(Rectangle())
                                            .font(.custom(fontvalue, size: CGFloat(maintext_fontsize)))
                                            .frame(width: 280, alignment: .leading)
                                            .multilineTextAlignment(maintext_alignment)
                                            .frame(minHeight: 150)
                                            .lineSpacing(CGFloat(maintext_linespacing))
                                            .accentColor(.black)
                                            .id("texteditorda")
                                        
                                        /// typing focus scroll
                                            .onChange(of: maintext) { _ in
                                                proxy.scrollTo("texteditorda", anchor: .bottom)
                                            }
        
                                        if maintext.isEmpty {
                                            VStack {
//                                                Text(Date().formatDate(Date().checkDateWithinRange(date: Date.now), using: .month_day_text))
                                                Text("Publish 버튼을 길게 눌러 일기를 등록하세요.")
                                                    .font(.custom(fontvalue, size: 16))
                                                    .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                                    .foregroundStyle(Color.gray.opacity(0.55))
                                                    .frame(width: 280, alignment: .leading)
                                                    .padding(.top, 10)
                                                    .padding(.leading, 6)
                                                Spacer()
                                            }
                                            .allowsHitTesting(false)
                                        }
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal, 26)
                                
                                Spacer()
                                
                            }.frame(width: AppConfig.homeWidth)
                                .padding(.bottom, 44)
                        }
                    }
                                        
                    HStack {
                        Rectangle().frame(width: 1, alignment: .center).padding(.leading, 28)
                            .foregroundStyle(.gray5)
                        Spacer()
                    }

//                    if popups_reflect {
//                        
//                        VStack {
//                            Spacer()
//                            InD_SwiftUIView()
//                            
//                        }.padding(.bottom, isThirdTab ? 56 : 6)
//                            .ignoresSafeArea(.container)
//                    } else {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                
                                publishButton(title: $title, status: $maintext, image: $url, emotions: $ispopups2, weathers: $ispopups, text_align: $maintext_alignment, text_spacing: $maintext_linespacing, donedone: $isPresented)
                                Spacer()
                            }
                        }.padding(.bottom, isThirdTab ? 56 : 6)
                            .ignoresSafeArea(.keyboard)
//                    }
                }
                .fullScreenCover(isPresented: $ispresented_imgpicker, content: {
                    CustomizedMediaPicker(
                        isPresented: $ispresented_imgpicker,
                        medias: $medias
                    )
                })
                .sheet(isPresented: $popups, content: {
                    PopupBottomFirst(isPresented: $popups, ispreint: $ispopups, ispreint2: $ispopups2)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(40)
                    
                })
                
            }
            .onAppear {
                isHiding = true
            }
            .toolbar {
                if !isThirdTab {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Cancel") {
                            isPresented = false
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
        .ignoresSafeArea()
//        .navigationTitle("")
//        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }

}


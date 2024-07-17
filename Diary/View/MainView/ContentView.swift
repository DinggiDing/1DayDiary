//
//  ContentView.swift
//  Diary
//
//  Created by 성재 on 2/25/24.
//

import SwiftUI
import Kingfisher
import CoreData
import Photos

struct ContentView: View {
    
    @Environment(\.locale) var locale: Locale
    @State var isShowingEditForm: Bool = false
    
    /// coredata
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var todos: FetchedResults<DB_core>
    let columns = [GridItem(.flexible(), spacing: 1)]

    @State private var favoriteColor = "Day"
    var colors = ["Day", "Month", "Year"]
    
    @Binding var isHiding : Bool
    @State var scrollOffset : CGFloat = 0
    @State var threshHold : CGFloat = 0
    
    @State var isPresented: Bool = false
    @State var today_on: Bool = false
    
    @AppStorage("MyfontValue") private var fontvalue: String = "Arita-buri-Medium_OTF"
    @AppStorage("MyTitlefontValue") private var titlefontvalue: String = "Arita-buri-Bold_OTF"

    @State var appear = false
    @FetchRequest var todos: FetchedResults<DB_core>
    
    init(isHiding: Binding<Bool>) {
        self._isHiding = isHiding
        
        let request: NSFetchRequest<DB_core> = DB_core.fetchRequest()
        
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \DB_core.date, ascending: false)
        ]
        request.fetchLimit = 10
        
        _todos = FetchRequest(fetchRequest: request)
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollView(content: {
                    ZStack {
                        VStack {
//                            Spacer().frame(height: 36)
                            if todos.isEmpty {
                                
                                HStack {
                                    Spacer()
                                    
                                    interButton(isShowingEditForm: $isShowingEditForm)
                                        .padding(.bottom, 52)
                                    Spacer()
                                }
                                .rotationEffect(.radians(.pi))
                                .scaleEffect(x: -1, y: 1, anchor: .center)
                                
                                HStack(spacing: 18) {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .foregroundColor(Color("gray6"))
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 5, height: 5)
                                    Text(Date().checkDateWithinRange(date: Date.now), format: .dateTime.day(.twoDigits).month(.twoDigits))
                                        .font(Font.SUIT_SemiBold_16(locale: locale))
                                        .foregroundStyle(.accent)
                                   
                                    Spacer()
                                }.padding(.bottom, 12)
                                    .rotationEffect(.radians(.pi))
                                    .scaleEffect(x: -1, y: 1, anchor: .center)
                                
                                
                            } else {
                                if !Date().checkBoolDateIsWithinRange(date: todos[0].date!) {
                                    HStack {
                                        Spacer()
                                        interButton(isShowingEditForm: $isShowingEditForm)
                                            .padding(.bottom, 52)
                                        Spacer()
                                    }
                                    .rotationEffect(.radians(.pi))
                                    .scaleEffect(x: -1, y: 1, anchor: .center)
                                    
                                    HStack(spacing: 18) {
                                        Image(systemName: "circle.fill")
                                            .resizable()
                                            .foregroundColor(Color("gray6"))
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 5, height: 5)
                                        Text(Date().checkDateWithinRange(date: Date.now), format: .dateTime.day(.twoDigits).month(.twoDigits))
                                            .font(Font.SUIT_SemiBold_16(locale: locale))
                                            .foregroundStyle(.accent)
                                        
                                        Spacer()
                                    }.padding(.bottom, 12)
                                        .rotationEffect(.radians(.pi))
                                        .scaleEffect(x: -1, y: 1, anchor: .center)
                                }
                                else {
                                    Spacer().frame(height: 20)
                                }
                            }
        
                            ForEach(todos.prefix(10), id: \.self) { todo in
                                NavigationLink(destination: {
                                    if Date().checkBoolDateIsWithinRange(date: todo.date!) {
                                        EditTodayView(db: todo, isPresented: $isPresented, isHiding: $isHiding)
                                    }
                                    else {
                                        ShowView(db: todo, isHiding: $isHiding)
                                    }
                                }, label: {
                                    HStack(alignment: .center) {
                                        VStack(alignment: .leading) {
                                            HStack(spacing: 16) {
                                                Image(systemName: "circle.fill")
                                                    .resizable()
                                                    .foregroundColor(Color("gray6"))
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 5, height: 5)
                                                
                                                if Date().checkBoolDateIsWithinRange(date: todo.date!) {
                                                    Text(Date().checkDateWithinRange(date: Date.now), format: .dateTime.day(.twoDigits).month(.twoDigits))
                                                        .font(Font.SUIT_SemiBold_16(locale: locale))
                                                        .foregroundStyle(.accent)
                                                }
                                                else {
                                                    Text(todo.date ?? Date.now, format: .dateTime.day(.twoDigits).month(.twoDigits))
                                                        .font(Font.SUIT_Regular(locale: locale))
                                                        .foregroundColor(.gray)
                                                }
                                                
                                                if todo.weathers != 0 {
                                                    Image(systemName: Mockdata.iconImageNames[Int(todo.weathers)-1])
                                                        .foregroundStyle(Mockdata.colors[Int(todo.weathers)-1])
                                                }
                                                
                                                if todo.emotions != 0 {
                                                    Text(Mockdata2.iconImageNames[Int(todo.emotions)-1])
                                                }
                                                Spacer()
                                            }.padding(.bottom, 16)
                                            
                                            HStack {
                                                Spacer()
                                                    VStack(alignment: .leading) {
                                                    Text(todo.title ?? "")
                                                        .font(.custom(titlefontvalue, size: 20))
                                                        .foregroundStyle(Color.black)
                                                        .frame(width: 280, alignment: .leading)
                                                        .padding(.bottom, 16)
                                                    
                                                    Text(todo.status ?? "")
                                                        .font(.custom(fontvalue, size: 14))
                                                        .foregroundStyle(Color.black)
                                                        .lineLimit(5)
                                                        .lineSpacing(10.0)
                                                        .frame(width: 280, alignment: .leading)
                                                        .multilineTextAlignment(.leading)
                                                        .padding(.bottom, 16)
                                                    
                                                    if !todo.image.isEmpty {
                                                        ScrollView(.horizontal) {
                                                            LazyHGrid(rows: columns, spacing: 10) {
                                                                ForEach(todo.image, id: \.self) { images in
                                                                    ContentImageView(imagePath: images)

                                                                }
                                                            }.frame(height: 150)
                                                        }
                                                    }
                                                }
                                                .frame(width: 280)
                                                Spacer()
                                            }
                                            
                                            Spacer().frame(height: 48)
                                            
                                        }
                                    }
                                    .listRowSeparator(.hidden)
                                    .rotationEffect(.radians(.pi))
                                    .scaleEffect(x: -1, y: 1, anchor: .center)
                                })
            
                            }
                            GeometryReader { proxy in
                                Color.clear
                                    .changeOverlayOnScroll(
                                        proxy: proxy,
                                        offsetHolder: $scrollOffset,
                                        thresHold: $threshHold,
                                        toggle: $isHiding
                                    )
                            }
                        }
                    }
                    .padding(.leading, 26)
                    .padding(.trailing, 26)
                })
                .scrollIndicators(.hidden)
                .coordinateSpace(name: "scroll")
                .rotationEffect(.radians(.pi))
                .scaleEffect(x: -1, y: 1, anchor: .center)
                
                HStack {
                    Rectangle().frame(width: 1, alignment: .center).padding(.leading, 28)
                        .foregroundStyle(.gray5)
                    Spacer()
                }
            }
            .onAppear {
                if !todos.isEmpty {
                    today_on = Date().checkBoolDateIsWithinRange(date: todos[0].date!)
                } else {
                    today_on = false
                }
                isHiding = false
                
//                let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
                
                // Local photo 현재 권한이 있는지 유무 확인
                PHPhotoLibrary.authorizationStatus(for: .readWrite)
//                print("STATUS : \(status)")
            }
            
            .navigationDestination(isPresented: $isShowingEditForm, destination: {
                EditView2(isPresented: $isShowingEditForm, isHiding: $isHiding, isThirdTab: false)
            })
            .navigationTitle("Writing Now")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ProfileView2(today_on: $today_on)
                }
            }
        }
    }
}

#Preview {
    MainView()
}


struct ContentImageView: View {
    let imagePath: URL

    var body: some View {
        VStack {
            KFImage(imagePath)
                .placeholder { // 플레이스 홀더 설정
                    ProgressView()
                }
                .retry(maxCount: 10, interval: .seconds(5))
                .resizable()
                .scaledToFill()
                .frame(width: 119, height: 153)
                .clipped()
//            AsyncImage(url: imagePath, content: { image in
//                image.resizable()
//                    .scaledToFill()
//                    .frame(width: 119, height: 153)
//                    .clipped()
//                
//            }, placeholder: {
//                ProgressView()
//                
//            })
                        
        }
        
    }
}

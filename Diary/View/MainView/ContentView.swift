//
//  ContentView.swift
//  Diary
//
//  Created by 성재 on 2/25/24.
//

import SwiftUI
import Kingfisher
import CoreData

struct ContentView: View {
    
    @State var isShowingEditForm: Bool = false
    
    /// coredata
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var todos: FetchedResults<DB_core>
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
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                ScrollView(content: {
                    ZStack {
                        VStack {
                            Spacer().frame(height: 36)

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
                                    Text(checkIfDateIsWithinRangeSave(date: Date.now), format: .dateTime.day(.twoDigits).month(.twoDigits))
                                        .font(.custom("SUIT-Semibold", size: 16))
                                        .foregroundStyle(.accent)
                                   
                                    Spacer()
                                }.padding(.bottom, 12)
                                    .rotationEffect(.radians(.pi))
                                    .scaleEffect(x: -1, y: 1, anchor: .center)
                                
                                
                            } else {
                                if !checkIfDateIsWithinRange(date: todos[0].date!) {
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
                                        Text(checkIfDateIsWithinRangeSave(date: Date.now), format: .dateTime.day(.twoDigits).month(.twoDigits))
                                            .font(.custom("SUIT-Semibold", size: 16))
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
                                    if checkIfDateIsWithinRange(date: todo.date!) {
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
                                                
                                                if checkIfDateIsWithinRange(date: todo.date!) {
                                                    Text(checkIfDateIsWithinRangeSave(date: Date.now), format: .dateTime.day(.twoDigits).month(.twoDigits))
                                                        .font(.custom("SUIT-Semibold", size: 16))
                                                        .foregroundStyle(.accent)
                                                }
                                                else {
                                                    Text(todo.date ?? Date.now, format: .dateTime.day(.twoDigits).month(.twoDigits))
                                                        .font(.SUIT_Regular)
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
                                                                    KFImage.url(images)
                                                                        .resizable()
                                                                        .scaledToFill()
                                                                        .frame(width: 119, height: 153)
                                                                        .clipped()
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
                    today_on = checkIfDateIsWithinRange(date: todos[0].date!)
                } else {
                    today_on = false
                }
                isHiding = false
                
                print("date = c \(Date())")
                print("date = cnow \(Date.now)")

                print("date = \(checkIfDateIsWithinRangeSave(date: Date()))")
                
                let currentHour = Calendar.current.component(.hour, from: Date())

                print("date = \(currentHour)")

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
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func checkIfDateIsWithinRange(date: Date) -> Bool {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: Date.now)
        let hour = components.hour ?? 0
        
        //        var startDate = Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!
        //        var endDate = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!)!
        
        //        if hour < 11 {
        //            startDate = Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!)!
        //            endDate = Calendar.current.date(byAdding: .day, value: 0, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!)!
        //        }
        
        //        if date >= startDate && date < endDate {
        //            return true
        //        }
        //        else {
        //            return false
        //        }
        var startDate = Date()
        
        if hour < 11 {
            startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        }
        
        if formatDate_compare(startDate) == formatDate_compare(date) {
            return true
        } else {
            return false
        }
    }
    
    private func checkIfDateIsWithinRangeSave(date: Date) -> Date {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: Date.now)
        let hour = components.hour ?? 0
        
        var startDate = Date()
        if hour < 11 {
            startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        }

        return startDate
    }
    
    private func formatDate_compare(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"
        return formatter.string(from: date)
    }
}

#Preview {
    MainView()
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(.main)
            .foregroundStyle(.white)
            .clipShape(Circle())
            
    }
}

extension View {
    
    func changeOverlayOnScroll(
        proxy : GeometryProxy,
        offsetHolder : Binding<CGFloat>,
        thresHold : Binding<CGFloat>,
        toggle: Binding<Bool>
    ) -> some View {
        self
            .onChange(
                of: proxy.frame(in: .named("scroll")).minY
            ) { newValue in
                // Set current offset
                offsetHolder.wrappedValue = abs(newValue)
                // If current offset is going downward we hide overlay after 200 px.
                if offsetHolder.wrappedValue > thresHold.wrappedValue + 200 {
                    // We set thresh hold to current offset so we can remember on next iterations.
                    thresHold.wrappedValue = offsetHolder.wrappedValue
                    // Hide overlay
                    toggle.wrappedValue = false
                    
                    // If current offset is going upward we show overlay again after 200 px
                }else if offsetHolder.wrappedValue < thresHold.wrappedValue - 200 {
                    // Save current offset to threshhold
                    thresHold.wrappedValue = offsetHolder.wrappedValue
                    // Show overlay
                    toggle.wrappedValue = true
                }
         }
    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 1, minute: 0, second: 0, of: self)!
    }
}

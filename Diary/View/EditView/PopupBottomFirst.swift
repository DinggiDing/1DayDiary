//
//  PopupBottomFirst.swift
//  Diary
//
//  Created by 성재 on 3/13/24.
//

import SwiftUI

struct PopupBottomFirst: View {
    
    @Binding var isPresented: Bool
    @Binding var ispreint: Int
    @Binding var ispreint2: Int
    
    @State private var gotosecond: Bool = false
    @State private var didTap: [Bool] = [false, false, false, false, false]
    @Environment(\.locale) var locale: Locale

    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            PopupBottomView(
                title: "Weather",
                items: Mockdata.textnames,                                    
                icons: Mockdata.iconImageNames,
                didTap: $didTap,
                columns: columns,
                locale: locale
            ) { index in
                handleTap(index: index)
            }
//            VStack {
//                Spacer()
//                Text("Weather")
//                    .foregroundColor(.black)
//                    .font(.custom("SUIT-Regular", size: 20))
//                
//                Spacer()
//                
//                HStack {
//                    Spacer()
//                    Spacer()
//                    LazyVGrid(columns: columns, spacing: 10) {
//                        ForEach(0..<5) { index in
//                            MainButton(imageName: Mockdata.iconImageNames[index], colorHex: "F3F2F7", text: Mockdata.textnames[index], didtap: didTap[index])
//                                .onTapGesture {
//                                    didTap = [false, false, false, false, false]
//                                    didTap[index] = true
//                                    ispreint = index + 1
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                        gotosecond.toggle()
//                                    }
//                                }
//                        }
//                    }.padding(.horizontal, 50)
//                    Spacer()
//                    Spacer()
//                }
//                
//                Spacer()
//                
//            }
            .navigationDestination(isPresented: $gotosecond, destination: {
                PopupBottomSecond(isPresented: $isPresented, ispreint2: $ispreint2)
            })
            .onAppear {
                if ispreint != 0 {
                    didTap[ispreint - 1] = true
                }
            }
        }
    }
    private func handleTap(index: Int) {
        didTap = [false, false, false, false, false]
        didTap[index] = true
        ispreint = index + 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            gotosecond.toggle()
        }
    }

}

struct MainButton<Content: View>: View {

    @Environment(\.locale) var locale: Locale

    var imageName: String
    var colorHex: String
    var text: LocalizedStringKey
    var didtap: Bool
    var width: CGFloat = 78
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            Color(hex: didtap ? "4B0082" : colorHex)
                .frame(width: width, height: width)
                .cornerRadius(width / 5)
                .shadow(color: Color(hex: colorHex).opacity(0.3), radius: 15, x: 0, y: 15)
            VStack {
                content()
//                Image(systemName: imageName)
                    .foregroundColor(didtap ? .white : .black)
                    .padding(.bottom, 5)
                Text(text).foregroundStyle(didtap ? .white : .black)
                    .font(Font.SUIT_Regular_13(locale: locale))
            }
        }
    }
}

@ViewBuilder
func PopupBottomView(title: String, items: [LocalizedStringKey], icons: [String], didTap: Binding<[Bool]>, columns: [GridItem], locale: Locale, onItemTap: @escaping (Int) -> Void) -> some View {
        
    VStack {
        Spacer()
        Text(title)
            .foregroundColor(.black)
            .font(Font.SUIT_Regular_20(locale: locale))
        
        Spacer()
        
        HStack {
            Spacer()
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<items.count, id: \.self) { index in
                    MainButton(imageName: icons[index], colorHex: "F3F2F7", text: items[index], didtap: didTap.wrappedValue[index]) {
                        if title == "Mood" {
                            Text(icons[index])
                        } else {
                            Image(systemName: icons[index])
                        }
                    }
                        .onTapGesture {
                            onItemTap(index)
                        }
                }
            }.padding(.horizontal, 50)
            Spacer()
        }
        
        Spacer()
    }
}

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
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Weather")
                    .foregroundColor(.black)
                    .font(.custom("SUIT-Regular", size: 20))
                
                Spacer()
                
                HStack {
                    Spacer()
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(0..<5) { index in
                            MainButton(imageName: Mockdata.iconImageNames[index], colorHex: "F3F2F7", text: Mockdata.textnames[index], didtap: didTap[index])
                                .onTapGesture {
                                    didTap = [false, false, false, false, false]
                                    didTap[index] = true
                                    ispreint = index + 1
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        gotosecond.toggle()
                                    }
                                }
                        }
                    }.padding(.horizontal, 50)
                    Spacer()
                    Spacer()
                }
                
                Spacer()
                
            }.navigationDestination(isPresented: $gotosecond, destination: {
                PopupBottomSecond(isPresented: $isPresented, ispreint2: $ispreint2)
            })
            .onAppear {
                if ispreint != 0 {
                    didTap[ispreint - 1] = true
                }
            }
        }
    }
}

struct MainButton: View {

    var imageName: String
    var colorHex: String
    var text: String
    var didtap: Bool
    var width: CGFloat = 78

    var body: some View {
        ZStack {
            Color(hex: didtap ? "4B0082" : colorHex)
                .frame(width: width, height: width)
                .cornerRadius(width / 5)
                .shadow(color: Color(hex: colorHex).opacity(0.3), radius: 15, x: 0, y: 15)
            VStack {
                Image(systemName: imageName)
                    .foregroundColor(didtap ? .white : .black)
                    .padding(.bottom, 5)
                Text(text).foregroundStyle(didtap ? .white : .black)
                    .font(.custom("SUIT-Regular", size: 13))
            }
        }
    }
}

struct IconButton: View {

    var imageName: String
    var color: Color
    let imageWidth: CGFloat = 20
    let buttonWidth: CGFloat = 45

    var body: some View {
        ZStack {
            Color(red: 3, green: 3, blue: 3)
            Image(systemName: imageName)
                .frame(width: imageWidth, height: imageWidth)
                .foregroundColor(color)
        }
        .frame(width: buttonWidth, height: buttonWidth)
        .cornerRadius(buttonWidth / 2)
    }
}

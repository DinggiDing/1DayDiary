//
//  PopupBottomSecond.swift
//  Diary
//
//  Created by 성재 on 3/15/24.
//

import SwiftUI

struct PopupBottomSecond: View {
    
    @Binding var isPresented: Bool
    @Binding var ispreint2: Int
    
    @State private var didTap: [Bool] = [false, false, false, false, false, false, false, false, false]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        PopupBottomView(
            title: "Mood",
            items: Mockdata2.textnames,
            icons: Mockdata2.iconImageNames,
            didTap: $didTap,
            columns: columns
        ) { index in
            handleTap(index: index)
        }
//        VStack {
//            Spacer()
//            Text("Mood")
//                .foregroundColor(.black)
//                .font(.custom("SUIT-Regular", size: 20))
//            
//            Spacer()
//            
//            HStack {
//                Spacer()
//                Spacer()
//                LazyVGrid(columns: columns, spacing: 10) {
//                    ForEach(0..<8) { index in
//                        MainButton(imageName: Mockdata2.iconImageNames[index], colorHex: "F3F2F7", text: Mockdata2.textnames[index], didtap: didTap[index])
//                            .onTapGesture {
//                                didTap = [false, false, false, false, false, false, false, false, false]
//                                didTap[index] = true
//                                ispreint2 = index + 1
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                    isPresented.toggle()
//                                }
//                            }
//                    }
//                }.padding(.horizontal, 50)
//                Spacer()
//                Spacer()
//            }
//            
//            Spacer()
//
//        }
        .navigationBarBackButtonHidden()
            .onAppear {
                if ispreint2 != 0 {
                    didTap[ispreint2 - 1] = true
                }
            }
    }
    
    private func handleTap(index: Int) {
        didTap = [false, false, false, false, false, false, false, false, false]
        didTap[index] = true
        ispreint2 = index + 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isPresented.toggle()
        }
    }
}

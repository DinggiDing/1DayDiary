//
//  interButton.swift
//  Diary
//
//  Created by 성재 on 3/22/24.
//

import SwiftUI

struct interButton: View {
    
    @State var fb = false
    @State var Hpress = false
    @GestureState var topG = false
    
    @Binding var isShowingEditForm : Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(
                    AngularGradient(gradient: Gradient(colors: [Color.mainpoint, Color.maingra]),
                                    center: .bottomLeading,
                                   angle: .degrees(0 + 45))
                )
                .frame(width: 150, height: 44)
                .cornerRadius(40)
                .shadow(color: .mainpoint.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: .white.opacity(0.6), radius: 10, x: 10, y:10)
            
            HStack(spacing: 13) {
                
                ZStack {
                    Image(systemName: "pencil.line")
                        .foregroundColor(.white)
                        .font(.system(size: 10, weight: .bold))
                }
                
                Text("Writing Now")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.6))
        .scaleEffect(Hpress ? 0.8 : 1)
        .gesture(
            TapGesture()
                .onEnded { _ in
                    Hpress = true
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.15, execute: {
                        Hpress.toggle()
                        isShowingEditForm.toggle()
                    })
                }
        )
    }
}

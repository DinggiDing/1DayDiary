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
        
        .scaleEffect(Hpress ? 0.85 : 1)
        .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.2), value: Hpress)
        .onTapGesture {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.65, execute: {
                isShowingEditForm.toggle()
                Hpress.toggle()

            })
            Hpress.toggle()
            
        }
//        .pressEvents {
//            // On press
//            withAnimation(.easeInOut(duration: 0.25)) {
//                Hpress = true
//                DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
//                    isShowingEditForm.toggle()
//                })
//            }
//        } onRelease: {
//            withAnimation {
//                Hpress = false
//                
//            }
//        }
    }
}

struct ButtonPress: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}

extension View {
    func pressEvents(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(ButtonPress(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}

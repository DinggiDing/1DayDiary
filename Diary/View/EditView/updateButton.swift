//
//  updateButton.swift
//  Diary
//
//  Created by 성재 on 5/12/24.
//

import SwiftUI
import Drops

struct updateButton: View {
    // MARK: Core data variables
   @EnvironmentObject var manager: DataManager
   @Environment(\.managedObjectContext) var viewContext
    
    @Binding var title : String
    @Binding var status : String
    @Binding var image : [URL]
    let db: DB_core
    @Binding var emotions: Int
    @Binding var weathers: Int
    @Binding var text_align: TextAlignment
    @Binding var text_spacing: Int
    
    @State var Hpress = false
    @Binding var donedone : Bool
    
    @GestureState var topG = false
    
    let drop = Drop(
        title: " Diary Saved! ",
        icon: UIImage(systemName: "square.and.arrow.down.fill"),
        action: .init {
//            print("Drop tapped")
            Drops.hideCurrent()
        },
        position: .top,
        duration: 4.0,
        accessibility: "Alert: Title"
    )
    
    
    
    var body: some View {

        ZStack {
            Rectangle().frame(width: 150, height: 44)
                .foregroundColor(Hpress ? .subpoint : .blackblue55)
                .cornerRadius(40)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: .white.opacity(0.6), radius: 10, x: 10, y:10)
            
            HStack(spacing: 13) {
                
                ZStack {
                    Circle().trim(from: 0, to : 1)
                        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .rotation(.degrees(-90))
                        .frame(width: 22, height: 22)
                        .foregroundStyle(.gray5).opacity(0.5)
                        .opacity(Hpress ? 0 : 1)
                    
                    Circle().trim(from: 0, to : topG ? 1 : 0)
                        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .rotation(.degrees(-90))
                        .frame(width: 22, height: 22)
                        .foregroundStyle(.gray5)
                        .scaleEffect(Hpress ? 0 : 1)
                    Image(systemName: "arrow.up")
                        .foregroundColor(.white)
                        .font(.system(size: 10, weight: .bold))
                        .scaleEffect(Hpress ? 0 : 1)
                        .offset(x: 0, y: topG ? -50: 0)
                        .opacity(topG ? 0 : 1)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.white)
                        .scaleEffect(Hpress ? 1 : 0)
                        .animation(.easeInOut, value: Hpress)
                }
                
                Text("Publish")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
        
        .animation(.easeInOut.speed(0.3), value: topG)
        .scaleEffect(topG ? 0.8 : 1)
        .gesture(LongPressGesture(minimumDuration: 1.0).updating($topG) { cstate, gstate, trantion in
            gstate = cstate
        }
            .onEnded({ value in
                Hpress.toggle()
                self.updateTodo(title: title=="" ? formatDate(Date.now) : title, date: Date.now, status: status, image: image, todo: db, emotions: Int16(emotions), weathers: Int16(weathers), text_align: text_align, text_spacing: Int16(text_spacing))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Drops.show(drop)
                    donedone.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    Hpress.toggle()
                }
            })
        )
    }
        
    private func updateTodo(title: String, date: Date, status: String, image: [URL], todo: DB_core, emotions: Int16, weathers: Int16, text_align: TextAlignment, text_spacing: Int16) {
        todo.title = title
        todo.status = status
        todo.image = image
        todo.emotions = emotions
        todo.weathers = weathers
        switch text_align {
        case .leading:
            todo.text_align = 1
        case .center:
            todo.text_align = 2
        case .trailing:
            todo.text_align = 3
        }
        todo.text_spacing = text_spacing
        
        do {
            try self.viewContext.save()
//            print("Todo saved!")
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 일기"
        return formatter.string(from: date)
    }
    
    
}

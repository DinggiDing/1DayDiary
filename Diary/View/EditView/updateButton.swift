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
        LongPressButton(
            title: "Publish"
        ) {
            self.updateTodo(title: title=="" ? Date().formatDate(Date.now, using: .month_day_text) : title, date: Date.now, status: status, image: image, todo: db, emotions: Int16(emotions), weathers: Int16(weathers), text_align: text_align, text_spacing: Int16(text_spacing))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                Drops.show(drop)
                donedone.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                Hpress.toggle()
            }
            
        }

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
    
}

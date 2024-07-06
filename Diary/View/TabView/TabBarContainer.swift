//
//  TabBarContainer.swift
//  Diary
//
//  Created by 성재 on 3/27/24.
//

import SwiftUI

struct TabBarContainer<Content: View>: View {
    let content: Content
    @Binding var selection: TabBarItem
    @State private var tabs: [TabBarItem] = [.home, .favorites, .messages, .profile]

    
    @Binding var isHiding : Bool
    
    init(selection: Binding<TabBarItem>, isHiding: Binding<Bool>,
         @ViewBuilder content: () -> Content) {
        self._selection = selection
        self._isHiding = isHiding
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection, content: {
                Group {
                    content
                        .ignoresSafeArea()
                }
                .toolbar(.automatic, for: .tabBar)
                .toolbarBackground(.hidden, for: .tabBar)
            })
            
            MaterialTabBar(tabs: tabs,
                           selection: $selection,
                           localSelection: selection)
            .opacity(isHiding ? 0 : 1)
        }
    }
}

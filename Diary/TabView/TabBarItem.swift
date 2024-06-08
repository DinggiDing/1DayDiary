//
//  TabBarItem.swift
//  Diary
//
//  Created by 성재 on 3/27/24.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home, favorites, profile, messages
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorites: return "rectangle.stack"
        case .profile: return "person"
        case .messages: return "clock.badge"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Albums"
        case .profile: return "Profile"
        case .messages: return "Highlight"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return .maingra
        case .favorites: return .maingra
        case .profile: return .maingra
        case .messages: return .maingra
        }
    }
}

//
//  Mockdata2.swift
//  Diary
//
//  Created by 성재 on 3/16/24.
//

// MARK: 날씨 및 감정 데이터

import Foundation
import SwiftUI

class Mockdata2 {
    static let colors = [
        "f7b731",
        "000000",
        "000000",
        "000000",
        "87ceeb"
    ].map { Color(hex: $0) }

    static let iconImageNames = [
        "😄",
        "🤕",
        "🥱",
        "😞",
        "😢",
        "😡",
        "🤭",
        "😋",
        "😍",
    ]
    
    static let iconImageNames2 = [
        "X",
        "😄",
        "🤕",
        "🥱",
        "😞",
        "😢",
        "😡",
        "🤭",
        "😋",
        "😍",
    ]
    
    static let textnames: [LocalizedStringKey] = [
        "밝음",
        "아픔",
        "피곤",
        "실망",
        "슬픔",
        "화남",
        "설렘",
        "맛있음",
        "하트",
    ]
    
    static let textnames2 = [
        " - ",
        "밝음",
        "아픔",
        "피곤",
        "실망",
        "슬픔",
        "화남",
        "설렘",
        "맛있음",
        "하트",
    ]
    
//    static let textnames2 = [
//        " -   ",
//        "밝음  ",
//        "아픔  ",
//        "피곤  ",
//        "실망  ",
//        "슬픔  ",
//        "화남  ",
//        "설렘  ",
//        "맛있음  ",
//        "하트  ",
//    ]
}


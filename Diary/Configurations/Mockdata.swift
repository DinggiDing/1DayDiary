//
//  Mockdata.swift
//  Diary
//
//  Created by 성재 on 3/16/24.
//

// MARK: 날씨 및 감정 데이터

import Foundation
import SwiftUI

class Mockdata {
    static let colors = [
        "f7b731",
        "000000",
        "000000",
        "000000",
        "87ceeb"
    ].map { Color(hex: $0) }

    static let iconImageNames = [
        "sun.max.fill",
        "cloud.fill",
        "wind",
        "cloud.rain.fill",
        "snowflake"
    ]
    
    static let textnames = [
        "맑음",
        "흐림",
        "바람",
        "비",
        "눈"
    ]
}

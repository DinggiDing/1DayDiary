//
//  FontUtililty.swift
//  Diary
//
//  Created by 성재 on 7/14/24.
//

import Foundation
import SwiftUI

struct FontManager {
    static func getFont(option: Country.FontOption, type: FontType, locale: Locale) -> String {
        let fontName: String
        var country: Country = .korea
                
        // locale.languageCode를 사용하여 국가를 설정합니다.
        if let languageCode = locale.language.languageCode?.identifier {
            switch languageCode {
            case "ja":
                country = .japan
            case "ko":
                country = .korea
            default:
                country = .korea
            }
        }
        
        switch type {
        case .body:
            fontName = option.bodyFont(for: country)
        case .title:
            fontName = option.titleFont(for: country)
        }
        return fontName
    }
}

enum Country {
    case korea
    case japan

    enum FontOption {
        case a
        case b
        case c
        case d

        func bodyFont(for country: Country) -> String {
            switch (country, self) {
            case (.korea, .a):
                return "Arita-buri-Medium_OTF"
            case (.korea, .b):
            return "NotoSansKR-Light"
            case (.korea, .c):
                return "SUITE-Light"
            case (.korea, .d):
                return "RIDIBatang"
            case (.japan, .a):
                return "NotoSerifJP-Light"
            case (.japan, .b):
                return "NotoSansJP-Light"
            case (.japan, .c):
                return "IBMPlexSansJP-Light"
            case (.japan, .d):
                return "ZenMaruGothic-Light"
            }
        }

        func titleFont(for country: Country) -> String {
            switch (country, self) {
            case (.korea, .a):
                return "Arita-buri-Bold_OTF"
            case (.korea, .b):
                return "NotoSansKR-Medium"
            case (.korea, .c):
                return "SUITE-Medium"
            case (.korea, .d):
                return "RIDIBatang"
            case (.japan, .a):
                return "NotoSerifJP-Medium"
            case (.japan, .b):
                return "NotoSansJP-Medium"
            case (.japan, .c):
                return "IBMPlexSansJP-Medium"
            case (.japan, .d):
                return "ZenMaruGothic-Medium"
            }
        }
    }
}


enum FontType {
    case body
    case title
}

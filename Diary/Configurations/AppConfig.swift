//
//  AppConfig.swift
//  Diary
//
//  Created by 성재 on 2/25/24.
//

// MARK: 글꼴 및 UI 사이즈

import Foundation
import SwiftUI

/// Generic configurations for the app
class AppConfig {
    
    // MARK: - UI Configurations
    static let homeWidth: CGFloat = UIScreen.main.bounds.width
    static let countdownWidth: CGFloat = UIScreen.main.bounds.width-56

    static let homeWidth2: CGFloat = UIScreen.main.bounds.width*0.712
    static let homeWidth3: CGFloat = UIScreen.main.bounds.width / 3
    static let homeHeight: CGFloat = UIScreen.main.bounds.height
    static let homeHeaderArticleHeight: CGFloat = UIScreen.main.bounds.height/2
    static let homeHeaderImageCornerRadius: CGFloat = 40.0
    static let homeLatestCarouselImageWidth: CGFloat = UIScreen.main.bounds.width/1.66
    static let homeLatestCarouselImageHeight: CGFloat = UIScreen.main.bounds.height/3
    
    // MARK: - Content placeholder while loading data
    static let placeholderLong = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    static let placeholderShort = "Lorem Ipsum is"
}

extension Font {
    
    // MARK: - Bold
    static let Arita_buriBold: Font = .custom("Arita-buri-Bold_OTF", size: 20)
//    static let Arita_buriBold_edt: Font = .custom("Arita-buri-Bold_OTF", size: 30)
    static func Arita_buriBold_edt(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("NotoSerifJP-Bold", size: 30)
        default:
            return .custom("Arita-buri-Bold_OTF", size: 30)
        }
    }
    static func Arita_buriBold_High(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("NotoSerifJP-Bold", size: 18)
        default:
            return .custom("Arita-buri-Bold_OTF", size: 18)
        }
    }
    
    static func memoryday_suit(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("IBMPlexSansJP-Regular", size: 15)
        default:
            return .custom("SUIT-Regular", size: 15)
        }
    }
    
    // MARK: - SemiBold
    static let Arita_buriSemibold: Font = .custom("Arita-buri-SemiBold_OTF", size: 16)
    

    // MARK: - Regular
//    static let SUIT_Regular: Font = .custom("SUIT-Regular", size: 16)
    static func SUIT_Regular(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("IBMPlexSansJP-Regular", size: 16)
        default:
            return .custom("SUIT-Regular", size: 16)
        }
    }
    static func SUIT_Regular_13(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("IBMPlexSansJP-Regular", size: 13)
        default:
            return .custom("SUIT-Regular", size: 13)
        }
    }
    static func SUIT_Regular_20(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("IBMPlexSansJP-Regular", size: 20)
        default:
            return .custom("SUIT-Regular", size: 20)
        }
    }
    static func SUITE_Medium(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("IBMPlexSansJP-Medium", size: 16)
        default:
            return .custom("SUITE-Medium", size: 16)
        }
    }
    
    static func SUIT_Bold(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("IBMPlexSansJP-Bold", size: 18)
        default:
            return .custom("SUIT-Bold", size: 18)
        }
    }
    static func SUIT_Bold_16(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("IBMPlexSansJP-Bold", size: 16)
        default:
            return .custom("SUIT-Bold", size: 16)
        }
    }
    static func SUIT_SemiBold_16(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("IBMPlexSansJP-SemiBold", size: 16)
        default:
            return .custom("SUIT-SemiBold", size: 16)
            // SemiBold? Semibold? (in ContentView)
        }
    }

    
    static func NotoSansKR_Regular_14(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("NotoSansJP-Regular", size: 14)
        default:
            return .custom("NotoSansKR-Regular", size: 14)
        }
    }
    static func NotoSansKR_Regular_15(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("NotoSansJP-Regular", size: 15)
        default:
            return .custom("NotoSansKR-Regular", size: 15)
        }
    }

    
    // MARK: - Medium
    static let Arita_buriMedium: Font = .custom("Arita-buri-Medium_OTF", size: 16)
    static func Arita_buriMedium(locale: Locale) -> Font {
        switch locale.identifier {
        case "ja":
            return .custom("NotoSerifJP-Medium", size: 16)
        default:
            return .custom("Arita-buri-Medium_OTF", size: 16)
        }
    }
    
    // MARK: - HairLine
    static let Arita_buriHariline: Font = .custom("Arita-buri-HairLine_OTF", size: 14)

    
    /// font 확인
    /// .onAppear {
    
//    for family: String in UIFont.familyNames {
//                    print(family)
//                    for names : String in UIFont.fontNames(forFamilyName: family){
//                        print("=== \(names)")
//                    }
//                }
//}
}

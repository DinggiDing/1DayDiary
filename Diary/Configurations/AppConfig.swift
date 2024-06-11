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
        
    // MARK: - News Categories
    static let categories = ["Health", "Politics", "Art", "Food", "Tech", "Sports", "Entertainment"]
    static let newsOfTheDay = "News of the Day"
    static let breakingNews = "Breaking News"
    
    // MARK: - UI Configurations
    static let homeWidth: CGFloat = UIScreen.main.bounds.width
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
    static let Arita_buriBold_edt: Font = .custom("Arita-buri-Bold_OTF", size: 30)
    
    
    // MARK: - SemiBold
    static let Arita_buriSemibold: Font = .custom("Arita-buri-SemiBold_OTF", size: 16)
    

    // MARK: - Regular
    static let SUIT_Regular: Font = .custom("SUIT-Regular", size: 16)

    
    // MARK: - Medium
    static let Arita_buriMedium: Font = .custom("Arita-buri-Medium_OTF", size: 16)
    
    
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

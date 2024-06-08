//
//  FavoriteBackyardTip.swift
//  Diary
//
//  Created by 성재 on 3/14/24.
//

import SwiftUI
import TipKit

struct FavoriteBackyardTip: Tip {
    var title: Text{
        Text("날씨와 기분")
            .foregroundStyle(.indigo)
    }
    
    var message: Text? {
        Text("날짜를 클릭해 오늘의 날씨와 기분을 설정해보세요")
    }
}

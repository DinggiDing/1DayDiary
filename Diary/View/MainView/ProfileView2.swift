//
//  ProfileView2.swift
//  Diary
//
//  Created by 성재 on 3/18/24.
//

import SwiftUI

struct ProfileView2: View {
    
    @Binding var today_on : Bool
        
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: today_on ? "circle.fill" : "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(today_on ? .green : .red)
                    .frame(width: 16, height: 16)
                    .shadow(color: .red.opacity(0.4), radius: 10, x: 1, y: 1)
                    .shadow(color: .white.opacity(0.6), radius: 10, x: 1, y:1)
                Text("일일 기록").font(.system(size: 12, weight: .semibold, design: .none))
                    .foregroundStyle(.gray3)
                Spacer()
            }
        }
    }
}

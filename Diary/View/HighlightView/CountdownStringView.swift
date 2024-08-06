//
//  CountdownStringView.swift
//  Diary
//
//  Created by 성재 on 8/1/24.
//

import SwiftUI

struct CountdownStringView: View {
    
    @StateObject private var viewModel = CountdownViewModel()
    @Environment(\.locale) var locale: Locale

    
    var body: some View {
        if viewModel.timeRemaining.isEmpty {
            ProgressView()
        } else {
            Text(viewModel.timeRemaining)
                .font(Font.SUIT_SemiBold_16(locale: locale))
                .foregroundStyle(.accent)
                .monospacedDigit()
        }
    }
}

#Preview {
    CountdownStringView()
}

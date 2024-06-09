//
//  CircularProgressView.swift
//  Diary
//
//  Created by 성재 on 5/14/24.
//

import SwiftUI

struct CircularProgressView: View {
  let progress: CGFloat

  var body: some View {
    ZStack {
      // Background for the progress bar
      Circle()
        .stroke(lineWidth: 10)
        .opacity(0.1)
        .foregroundColor(.subpoint)

      // Foreground or the actual progress bar
      Circle()
        .trim(from: 0.0, to: min(progress, 1.0))
        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        .foregroundColor(.subpoint)
        .rotationEffect(Angle(degrees: 270.0))
        .animation(.linear, value: progress)
    }
  }
}

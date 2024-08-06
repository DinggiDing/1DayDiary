//
//  CountdownView.swift
//  Diary
//
//  Created by 성재 on 6/16/24.
//

import SwiftUI
import Combine

struct CountdownView: View {
//    @State private var remainingTime: TimeInterval = nextDayElevenAM().timeIntervalSinceNow
//    @State private var timerSubscription: AnyCancellable?
    @StateObject private var viewModel = CountdownViewModel()
    @Environment(\.locale) var locale: Locale


    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15.0).foregroundStyle(.whitegray)
                .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 5)
            VStack(alignment: .leading) {
                
                Text("오늘의 기억을 기록할 남은 시간")
                    .font(.subheadline)
                    .foregroundStyle(.darkblue)
                    .padding(4)
                
                if viewModel.timeRemaining.isEmpty {
                    ProgressView()
                } else {
                    Text(viewModel.timeRemaining)
                        .font(.largeTitle)
                        .fontWeight(.regular)
                        .monospacedDigit()
                }
                
                ProgressView(value: viewModel.progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(.darkblue)
                    .scaleEffect(x: 1, y: 4, anchor: .center)
                    .padding(.vertical)
                    .animation(.easeInOut)

            }
            .padding()
        }
        .frame(width: AppConfig.homeWidth-30, height: 100)

        .padding()
        .padding(.vertical, 16)
//        .frame(width: AppConfig.countdownWidth)
    }

    
}

#Preview {
    CountdownView()
        .environment(\.locale, .init(identifier: "ja"))
}

class CountdownViewModel: ObservableObject {
    @Published var timeRemaining: String = ""
    @Published var progress: Double = 0.0
    private var cancellable: AnyCancellable?
    
    init() {
        startCountdown()
    }
    
    private func startCountdown() {
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .map { _ in self.calculateTimeRemaining() }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (timeString, progress) in
                self.timeRemaining = timeString
                self.progress = progress
            })
    }
    
    private func calculateTimeRemaining() -> (String, Double) {
        let now = Date()
        let calendar = Calendar.current
        
        var targetDateComponents = calendar.dateComponents([.year, .month, .day], from: now)
        targetDateComponents.hour = 11
        targetDateComponents.minute = 0
        targetDateComponents.second = 0
        
        if let targetDate = calendar.date(from: targetDateComponents), targetDate < now {
            // If target time today has passed, set target time to tomorrow
            targetDateComponents.day! += 1
        }
        
        let targetDate = calendar.date(from: targetDateComponents)!
        let timeInterval = targetDate.timeIntervalSince(now)
        
        let hours = Int(timeInterval) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60
        
        let totalSecondsInDay = 24 * 60
        let secondsRemaining = Int(timeInterval) / 60
//        let secondsRemaining = Int(timeInterval)
        let progress = Double(secondsRemaining) / Double(totalSecondsInDay)
        
        let timeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        
        return (timeString, progress)
    }
}

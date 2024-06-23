//
//  CountdownView.swift
//  Diary
//
//  Created by 성재 on 6/16/24.
//

import SwiftUI
import Combine

struct CountdownView: View {
    @State private var remainingTime: TimeInterval = nextDayElevenAM().timeIntervalSinceNow
    @State private var timerSubscription: AnyCancellable?
    @State private var weightpercent: Double = 0.9

    var body: some View {
        VStack {
            Text(timeString(time: remainingTime))
                .font(.largeTitle)
                .padding()
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 15.0)
                    .frame(height: 5)
                    .foregroundStyle(.gray)
                
                RoundedRectangle(cornerRadius: 15.0)
                    .frame(width: CGFloat(CGFloat(timeString2(time: remainingTime)) * AppConfig.homeWidth), height: 5)
                    .foregroundStyle(.green)
            }
        }
        .onAppear {
            startTimer()
        }
//        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }

    func startTimer() {
        stopTimer()  // 기존 타이머를 정지
        timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                updateRemainingTime()
            }
    }
//
    func stopTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }

    private func updateRemainingTime() {
        let timeInterval = nextDayElevenAM().timeIntervalSinceNow
        if timeInterval > 0 {
            remainingTime = timeInterval
        } 
//         }
    }
    
    
}

#Preview {
    CountdownView()
}

// 다음 날 오전 11시를 계산하는 함수
func nextDayElevenAM() -> Date {
    var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    components.day! += 1
    components.hour = 11
    components.minute = 0
    components.second = 0
    return Calendar.current.date(from: components)!
}

// 남은 시간을 포맷팅하는 함수
func timeString(time: TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
}

// 남은 시간을 퍼셋팅하는 함수
func timeString2(time: TimeInterval) -> Double {
    let interval = (Double(Int(time) / 60) / 1440)
    return Double(interval)
}

//
//  DateUtility.swift
//  Diary
//
//  Created by 성재 on 6/11/24.
//

import Foundation

extension Date {
    // Auth
    func isWithinPast(minutes: Int) -> Bool {
        let now = Date.now
        let timeAgo = Date.now.addingTimeInterval(-1 * TimeInterval(60 * minutes))
        let range = timeAgo...now
        return range.contains(self)
    }
    
    
    
    // This Month Start
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
    func endOfMonth() -> Date {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    // This Year Start
    func startOfYeear() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }

    func endOfYear() -> Date {
        let interval = Calendar.current.dateInterval(of: .year, for: self)
        return interval!.end
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone    = TimeZone.current
        let seconds     = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    
    static var yesterday: Date {
        return Date().dayBefore
    }
    
    static var tomorrow:  Date {
        return Date().dayAfter
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 1, minute: 0, second: 0, of: self)!
    }
    

    func checkBoolDateIsWithinRange(date: Date) -> Bool {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: Date.now)
        let hour = components.hour ?? 0
 
        var startDate = Date()
        
        if hour < 11 {
            startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        }
        
        if Date().formatDate(startDate, using: .compare) == Date().formatDate(date, using: .compare) {
            return true
        } else {
            return false
        }
    }
    
    func checkDateWithinRange(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: Date.now)
        let hour = components.hour ?? 0
        
        var startDate = Date()
        if hour < 11 {
            startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        }

        return startDate
    }
    
    func formatDate(_ date: Date, using format: DateFormat_date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }
    
    func formatDate(_ date: Date, locale: Locale) -> String {
        var format : DateFormat_date = .month_day_text
        if let languageCode = locale.language.languageCode?.identifier {
            switch languageCode {
            case "ja":
                format = .month_day_text_ja
            case "ko":
                format = .month_day_text
            default:
                format = .month_day_text_en
            }
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }
}

enum DateFormat_date: String {
    case year = "YYYY"
    case month = "MM"
    case month_day = "MM / dd"
    case month_text = "MMM"
    case day = "dd"
    case month_day_text = "MMM dd일 일기"
    case month_day_text_ja = "MMM dd日 日記"
    case month_day_text_en = "MMM dd"
    case compare = "YYYYMMdd"
}



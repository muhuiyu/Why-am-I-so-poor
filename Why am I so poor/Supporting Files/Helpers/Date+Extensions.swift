//
//  Date+Extensions.swift
//  Fastiee
//
//  Created by Mu Yu on 6/27/22.
//

import Foundation

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}

// MARK: - Get certain day
extension Date {
    var dayBefore: Date { self.day(before: 1) }
    var dayAfter: Date { self.day(after: 1) }
    
    func day(before numberOfDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -numberOfDays, to: noon)!
    }
    func day(after numberOfDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: numberOfDays, to: noon)!
    }
    
    var noon: Date { Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)! }
    var year: Int { Calendar.current.component(.year, from: self) }
    var month: Int { Calendar.current.component(.month, from: self) }
    var dayOfMonth: Int { Calendar.current.component(.day, from: self) }
    
    func getSundayInThisWeek() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: self)
        return self.day(before: weekDay-1)
    }
}

// MARK: - Determine
extension Date {
    var isFirstDayOfMonth: Bool { dayBefore.month != month }
    var isLastDayOfMonth: Bool { dayAfter.month != month }
    
    func isTodayWeekend() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: self)
        return (weekDay == 1 || weekDay == 7)
    }
    func isToday(weekDay: Int) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let todayWeekDay = calendar.component(.weekday, from: self)
        return (todayWeekDay == weekDay)
    }
}

// MARK: - Date Formatter
extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
    
    func printWeekDayAndDay() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: self)
        return dateFormatterPrint.weekdaySymbols[weekDay - 1] + ", " + dateFormatterPrint.string(from: self)
    }
    func printWeekDayAndDayWithoutYear() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: self)
        return dateFormatterPrint.weekdaySymbols[weekDay - 1] + ", " + dateFormatterPrint.string(from: self)
    }
    func printDay() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        return dateFormatterPrint.string(from: self)
    }
    func printDayWithoutYear() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        return dateFormatterPrint.string(from: self)
    }
    func printDayAndTime() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return dateFormatterPrint.string(from: self)
    }
    func toHistoryID() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        return dateFormatterPrint.string(from: self) + "-history-entry"
    }
}

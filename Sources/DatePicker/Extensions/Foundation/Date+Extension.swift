//
//  Date+Extension.swift
//  DatePicker
//
//  Created by zhussupali on 01.03.2024.
//

import Foundation

public extension Date {
    var day: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return Int(dateFormatter.string(from: self))!
    }
    
    var weekday: Weekday {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "c"
        return Weekday(rawValue: Int(dateFormatter.string(from: self))! - 1)!
    }
    
    var month: Month {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return Month(rawValue: Int(dateFormatter.string(from: self))! - 1)!
    }
  
    var year: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return Int(dateFormatter.string(from: self))!
    }
    
    var startOfMonth: Date {
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: self)
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        return calendar.date(from: components)!.addingTimeInterval(TimeInterval(calendar.timeZone.secondsFromGMT(for: currentDate)))
    }
    
    var endOfMonth: Date {
        Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
    }
    
    var startOfDay: Date {
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: self)
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        return calendar.date(from: components)!.addingTimeInterval(TimeInterval(calendar.timeZone.secondsFromGMT(for: currentDate)))
    }
    
    var endOfDay: Date {
        Calendar.current.date(byAdding: DateComponents(hour: 23, minute: 59, second: 59), to: startOfDay)!
    }
    
    var monthDays: [Date] {
        let endOfMonthDay = startOfMonth.endOfMonth.day
        return Array(0..<endOfMonthDay).compactMap { startOfMonth.date(byAdding: .day, value: $0) }
    }
    
    init?(day: Int, month: Month, year: Int) {
        guard let data = "\(day).\(month.id + 1).\(year)".toDate() else { return nil }
        self = data
    }
    
    func date(byAdding component: Calendar.Component, value: Int) -> Date {
        Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
    func range(to date: Date) -> [Date] {
        var dates: [Date] = []
        var currentDate = self
        while currentDate <= date.endOfDay {
            dates.append(currentDate)
            currentDate = currentDate.date(byAdding: .day, value: 1).startOfDay
        }
        return dates
    }
    
    func description(_ data: DatePickerData..., separator: String = ".") -> String {
        var array: [String] = []
        data.forEach { d in
            switch d {
            case .day:
                array.append(day.description)
            case let .weekday(format):
                array.append(weekday.description(in: format))
            case let .month(format):
                array.append(month.description(in: format))
            case .year:
                array.append(year.description)
            }
        }
        return array.joined(separator: separator)
    }
}

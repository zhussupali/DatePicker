//
//  CalendarViewSections.swift
//  DatePicker
//
//  Created by zhussupali on 04.03.2024.
//

import Foundation

public struct CalendarViewModel {
    var month: Month
    var year: Int
    var startIndex: Int
    var dates: [Date]
    var numberOfItems: Int { startIndex + dates.count }
    
    init(date: Date) {
        month = date.month
        year = date.year
        startIndex = date.startOfMonth.weekday.id
        dates = date.monthDays
    }
}

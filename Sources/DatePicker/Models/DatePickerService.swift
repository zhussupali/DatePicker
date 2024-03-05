//
//  DatePickerService.swift
//  DatePicker
//
//  Created by zhussupali on 29.02.2024.
//

import Foundation

public enum DatePickerData {
    case day
    case weekday(format: Weekday.Format = .name)
    case month(format: Month.Format = .name)
    case year
}

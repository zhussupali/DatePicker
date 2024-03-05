//
//  Weekday.swift
//  DatePicker
//
//  Created by zhussupali on 29.02.2024.
//

import Foundation

public enum Weekday: Int, Identifiable {
    public enum Format {
        case numeric
        case name
    }
    
    public var id: Int {
        rawValue
    }
    
    var name: String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
    
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    func description(in format: Format) -> String {
        switch format {
        case .numeric:
            (id + 1).description
        case .name:
            name
        }
    }
}

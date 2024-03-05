//
//  Month.swift
//  DatePicker
//
//  Created by zhussupali on 29.02.2024.
//

import Foundation

public enum Month: Int, Identifiable, CaseIterable {
    public enum Format {
        case numeric
        case name
    }
    
    public var id: Int {
        rawValue
    }
    
    var name: String {
        switch self {
        case .january:
            return "January"
        case .february:
            return "February"
        case .march:
            return "March"
        case .april:
            return "April"
        case .may:
            return "May"
        case .june:
            return "June"
        case .july:
            return "July"
        case .august:
            return "August"
        case .september:
            return "September"
        case .october:
            return "October"
        case .november:
            return "November"
        case .december:
            return "December"
        }
    }
    
    var next: Month {
        let allCases = Month.allCases
        let currentIndex = allCases.firstIndex(of: self)!
        let nextIndex = (currentIndex + 1) % allCases.count
        return allCases[nextIndex]
    }
    
    var previous: Month {
        let allCases = Month.allCases
        let currentIndex = allCases.firstIndex(of: self)!
        let previousIndex = (currentIndex + allCases.count - 1) % allCases.count
        return allCases[previousIndex]
    }
    
    case january
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
    
    func description(in format: Format) -> String {
        switch format {
        case .numeric:
            (id + 1).description
        case .name:
            name
        }
    }
}

//
//  DateFormat.swift
//  DatePicker
//
//  Created by zhussupali on 29.02.2024.
//

import Foundation

enum DateFormat {
    case `default`
    case custom(format: String)
    
    var format: String {
        switch self {
        case .default:
            "dd.MM.yyyy"
        case let .custom(format):
            format
        }
    }
}

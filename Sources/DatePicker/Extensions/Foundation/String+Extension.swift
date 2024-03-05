//
//  String+Extension.swift
//  DatePicker
//
//  Created by zhussupali on 01.03.2024.
//

import Foundation

extension String {
    func toDate(format: DateFormat = .default) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.format
        return dateFormatter.date(from: self)
    }
}

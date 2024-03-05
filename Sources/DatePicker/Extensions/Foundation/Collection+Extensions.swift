//
//  Collection+Extensions.swift
//  DatePicker
//
//  Created by zhussupali on 04.03.2024.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

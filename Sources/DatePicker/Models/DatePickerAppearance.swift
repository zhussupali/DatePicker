//
//  DatePickerAppearance.swift
//
//
//  Created by zhussupali on 06.03.2024.
//

import UIKit

public final class DatePickerAppearance {
    public final class Main {
        public var backgroundColor: UIColor = .clear
    }
    
    public final class Elements {
        public var dateTextColor: UIColor = .black
        public var headerTextColor: UIColor = .black
        
        public var selectedDateEdgeBackgroundColor: UIColor = .black
        public var selectedDateEdgeTextColor: UIColor = .white
        
        public var selectedDateBackgroundColor: UIColor = .gray
        public var selectedDateTextColor: UIColor = .white
        
        
        public var headerFont: UIFont = UILabel().font
        public var datesFont: UIFont = UILabel().font
    }
    
    public final class Header {
        public var backgroundColor: UIColor = .white
        public var elementsBackgroundColor: UIColor = .white
        public var textColor: UIColor = .black
        public var periodFont: UIFont = UILabel().font
        public var weekdaysFont: UIFont = UILabel().font
    }
    
    public let main = Main()
    public let elements = Elements()
    public let header = Header()
}

//
//  DatePickerHeaderView.swift
//
//
//  Created by zhussupali on 19.03.2024.
//

import UIKit

final class DatePickerHeaderView: UIView {
    private static let start = "От"
    private static let end = "До"
    
    private let startPeriodView: PeriodView = {
        let view = PeriodView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textLabel.text = DatePickerHeaderView.start
        return view
    }()
    
    private let endPeriodView: PeriodView = {
        let view = PeriodView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textLabel.text = DatePickerHeaderView.end
        return view
    }()
    
    private let weekdaysView: WeekdaysView = {
        let view = WeekdaysView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - Public methods

extension DatePickerHeaderView {
    func configure(startDate: String?) {
        startPeriodView.textLabel.text = startDate ?? DatePickerHeaderView.start
    }
    
    func configure(endDate: String?) {
        endPeriodView.textLabel.text = endDate ?? DatePickerHeaderView.end
    }
    
    func configure(appearance: DatePickerAppearance.Header) {
        backgroundColor = appearance.backgroundColor
        startPeriodView.backgroundColor = appearance.elementsBackgroundColor
        endPeriodView.backgroundColor = appearance.elementsBackgroundColor
        weekdaysView.backgroundColor = appearance.elementsBackgroundColor
        startPeriodView.textLabel.textColor = appearance.textColor
        endPeriodView.textLabel.textColor = appearance.textColor
        weekdaysView.labels.forEach {
            $0.textColor = appearance.textColor
            $0.font = appearance.weekdaysFont
        }
    }
}

// MARK: - Private methods

private extension DatePickerHeaderView {
    func setupView() {
        addSubview(startPeriodView)
        addSubview(endPeriodView)
        addSubview(weekdaysView)
        
        NSLayoutConstraint.activate([
            startPeriodView.leftAnchor.constraint(equalTo: leftAnchor),
            startPeriodView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            startPeriodView.rightAnchor.constraint(equalTo: centerXAnchor, constant: -4),
            
            endPeriodView.leftAnchor.constraint(equalTo: centerXAnchor, constant: 4),
            endPeriodView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            endPeriodView.rightAnchor.constraint(equalTo: rightAnchor),
            
            weekdaysView.topAnchor.constraint(equalTo: startPeriodView.bottomAnchor, constant: 16),
            weekdaysView.leftAnchor.constraint(equalTo: leftAnchor),
            weekdaysView.rightAnchor.constraint(equalTo: rightAnchor),
            weekdaysView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

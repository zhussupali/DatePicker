//
//  DatePickerCollectionCell.swift
//
//
//  Created by zhussupali on 15.03.2024.
//

import UIKit

protocol DatePickerCollectionCellDelegate: AnyObject {
    func didSelect(date: Date)
}

final class DatePickerCollectionCell: UICollectionViewCell {
    weak var delegate: DatePickerCollectionCellDelegate?
    
    private lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
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

extension DatePickerCollectionCell {
    func configure(calendar viewModel: CalendarViewModel) {
        calendarView.configure(with: viewModel)
    }
    
    func configure(selectedDates: [Date]) {
        calendarView.configure(selectedDates: selectedDates)
    }
}

// MARK: - Private methods

private extension DatePickerCollectionCell {
    func setupView() {
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = .yellow
        contentView.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            calendarView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            calendarView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -16),
            calendarView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - CalendarViewDelegate

extension DatePickerCollectionCell: CalendarViewDelegate {
    func didSelect(date: Date) {
        delegate?.didSelect(date: date)
    }
}

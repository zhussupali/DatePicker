//
//  DatePickerTableCell.swift
//
//
//  Created by zhussupali on 15.03.2024.
//

import UIKit

protocol DatePickerTableCellDelegate: AnyObject {
    func didSelect(date: Date)
}

final class DatePickerTableCell: UITableViewCell {
    weak var delegate: DatePickerTableCellDelegate?
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - Public methods

extension DatePickerTableCell {
    func configure(calendar viewModel: CalendarViewModel) {
        calendarView.configure(with: viewModel)
    }
    
    func configure(selectedDates: [Date]) {
        calendarView.configure(selectedDates: selectedDates)
    }
}

// MARK: - Private methods

private extension DatePickerTableCell {
    func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            calendarView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            calendarView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            calendarView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            containerView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
}

// MARK: - CalendarViewDelegate

extension DatePickerTableCell: CalendarViewDelegate {
    func didSelect(date: Date) {
        delegate?.didSelect(date: date)
    }
}

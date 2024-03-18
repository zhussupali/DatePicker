//
//  CalendarHeaderView.swift
//  DatePicker
//
//  Created by zhussupali on 04.03.2024.
//

import UIKit

final class CalendarHeaderView: UICollectionReusableView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

// MARK: - Public methods

extension CalendarHeaderView {
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    func configure(appearnace: DatePickerAppearance) {
        backgroundColor = appearnace.backgroundColor
        titleLabel.textColor = appearnace.headerLabelColor
        titleLabel.font = appearnace.headerFont
    }
}

// MARK: - Private methods

private extension CalendarHeaderView {
    func setupView() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

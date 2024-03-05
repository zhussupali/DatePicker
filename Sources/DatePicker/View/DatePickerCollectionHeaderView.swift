//
//  DatePickerCollectionHeaderView.swift
//  DatePicker
//
//  Created by zhussupali on 04.03.2024.
//

import UIKit

final class DatePickerCollectionHeaderView: UICollectionReusableView {
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

extension DatePickerCollectionHeaderView {
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

private extension DatePickerCollectionHeaderView {
    func setupView() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
}

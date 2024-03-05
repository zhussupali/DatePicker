//
//  DatePickerCollectionViewCell.swift
//  DatePicker
//
//  Created by zhussupali on 29.02.2024.
//

import UIKit

final class DatePickerCollectionViewCell: UICollectionViewCell {
    private var containerSelectedColor: UIColor?
    private var lineSelectedColor: UIColor?
    private var labelSelectedColor: UIColor?
    private var labelSelectedOnEdgeColor: UIColor = .white
    private var labelNormalColor: UIColor?
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = labelNormalColor
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        containerView.backgroundColor = .clear
        lineView.backgroundColor = .clear
        label.textColor = labelNormalColor
    }
}

// MARK: - Public methods

extension DatePickerCollectionViewCell {
    func configure(with appearance: DatePickerAppearance) {
        containerSelectedColor = appearance.containerSelectedColor
        lineSelectedColor = appearance.lineSelectedColor
        labelSelectedColor = appearance.labelSelectedColor
        labelSelectedOnEdgeColor = appearance.labelSelectedOnEdgeColor
        labelNormalColor = appearance.labelNormalColor
        backgroundColor = appearance.backgroundColor
        
        label.textColor = labelNormalColor
        label.font = appearance.datesFont
    }
    
    func setSelected(_ selected: Bool, isEdge: Bool) {
        containerView.backgroundColor = selected && isEdge ? containerSelectedColor : .clear
        lineView.backgroundColor = selected ? lineSelectedColor : .clear
        let selectedLabelColor = isEdge ? labelSelectedOnEdgeColor : labelSelectedColor
        label.textColor = selected ? selectedLabelColor : labelNormalColor
        if isEdge {
            lineView.constraints.forEach(lineView.removeConstraint)
            NSLayoutConstraint.activate([
                lineView.topAnchor.constraint(lessThanOrEqualTo: contentView.topAnchor, constant: 4),
                lineView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                lineView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                lineView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -4),
            ])
        } else {
            lineView.constraints.forEach(lineView.removeConstraint)
            NSLayoutConstraint.activate([
                lineView.topAnchor.constraint(lessThanOrEqualTo: contentView.topAnchor, constant: 4),
                lineView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                lineView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                lineView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -4),
            ])
        }
    }
}

// MARK: - Private methods

private extension DatePickerCollectionViewCell {
    func setupView() {
        contentView.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(lessThanOrEqualTo: contentView.topAnchor, constant: 4),
            lineView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            lineView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            lineView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -4),
        ])
        
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(lessThanOrEqualTo: contentView.topAnchor, constant: 4),
            containerView.leftAnchor.constraint(lessThanOrEqualTo: contentView.leftAnchor, constant: 4),
            containerView.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor, constant: -4),
            containerView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -4),
        ])
        
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}

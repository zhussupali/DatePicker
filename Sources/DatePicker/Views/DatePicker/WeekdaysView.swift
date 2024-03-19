//
//  WeekdaysView.swift
//
//
//  Created by zhussupali on 19.03.2024.
//

import UIKit

final class WeekdaysView: UIView {
    private(set) var labels: [UILabel] = []
    
    private lazy var stackView: UIStackView = {
        labels = getLabels()
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
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

// MARK: - Private methods

private extension WeekdaysView {
    func setupView() {
        layer.cornerRadius = 16
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func getLabels() -> [UILabel] {
        ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"].compactMap {
            let label = UILabel()
            label.text = $0
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: 32),
                label.widthAnchor.constraint(equalToConstant: 32)
            ])
            return label
        }
    }
}

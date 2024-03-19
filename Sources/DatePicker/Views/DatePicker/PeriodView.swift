//
//  PeriodView.swift
//
//
//  Created by zhussupali on 19.03.2024.
//

import UIKit

final class PeriodView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "calendar", in: .module, compatibleWith: nil)
        return imageView
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

private extension PeriodView {
    func setupView() {
        layer.cornerRadius = 16
        addSubview(imageView)
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            textLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            textLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}

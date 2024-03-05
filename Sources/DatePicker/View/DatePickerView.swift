//
//  DatePickerView.swift
//  DatePicker
//
//  Created by zhussupali on 29.02.2024.
//

import UIKit

protocol DatePickerViewDelegate: AnyObject {
    
}

public final class DatePickerView: UIView {
    public enum MonthDisplayMode: Equatable {
        case oneMonth
        case monthRange(from: Date?, to: Date?)
        case allMonths
    }
    
    static let headerHeight: CGFloat = 50
    static var cellSize: CGFloat = 0
    
    weak var delegate: DatePickerViewDelegate?
    
    private let displayMode: MonthDisplayMode = .allMonths
    
    private lazy var heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100)
    
    private lazy var dataSource: DatePickerViewDataSource = {
        let dataSource = DatePickerViewDataSource()
        dataSource.delegate = self
        dataSource.configure(selectionStyle: .range)
        return dataSource
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.headerReferenceSize = CGSize(width: collectionView.frame.size.width, height: DatePickerView.headerHeight)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = displayMode != .oneMonth
        collectionView.backgroundColor = .clear
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.register(DatePickerCollectionViewCell.self, forCellWithReuseIdentifier: DatePickerCollectionViewCell.description())
        collectionView.register(DatePickerCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DatePickerCollectionHeaderView.description())
        return collectionView
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

public extension DatePickerView {
    func configure(month: Month, year: Int) {
        guard let date = Date(day: 1, month: month, year: year) else { return }
        configure(with: date)
    }
    
    func configure(with date: Date) {
        var sections = [DatePickerViewSections(date: date)]
        
        if displayMode != .oneMonth {
            let previous = date.date(byAdding: .month, value: -1)
            let next = date.date(byAdding: .month, value: 1)
            sections.insert(.init(date: previous), at: 0)
            sections.append(.init(date: next))
        }
        
        dataSource.configure(sections: sections)
        collectionView.reloadData()
    }
    
    func configure(appearance: (DatePickerAppearance) -> Void) {
        appearance(dataSource.appearance)
        collectionView.reloadData()
    }
}

// MARK: - Private methods

private extension DatePickerView {
    func setupView() {
        backgroundColor = .clear
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - DatePickerViewDataSourceDelegate

extension DatePickerView: DatePickerViewDataSourceDelegate {
    func loadPreviousSection() {
        guard let date = dataSource.sections.first?.dates.first,
              isPagingEnabled(for: date)
        else { return }
        
        let previous = date.date(byAdding: .month, value: -1)
        dataSource.configure(sections: [.init(date: previous)] + dataSource.sections)
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 1), at: .top, animated: false)
    }
    
    func loadNextSection() {
        guard let date = dataSource.sections.last?.dates.last,
              isPagingEnabled(for: date)
        else { return }
        
        let next = date.date(byAdding: .month, value: 1)
        dataSource.configure(sections: dataSource.sections + [.init(date: next)])
        collectionView.reloadData()
    }
    
    func updateHeightIfNeeded() {
        heightConstraint.isActive = displayMode == .oneMonth
        guard case .oneMonth = displayMode else { return }
        let height = DatePickerView.headerHeight + (DatePickerView.cellSize * CGFloat(dataSource.sections[safe: 0]?.dates.count ?? 0) / 7) + 32
        heightConstraint.constant = height
    }
    
    func isPagingEnabled(for date: Date) -> Bool {
        switch displayMode {
        case .allMonths:
            return true
        case let .monthRange(from: startDate, to: endDate):
            var startEnabled = true
            var endEnabled = true
            
            if let startDate {
                startEnabled = startDate < date
            }
            if let endDate {
                endEnabled = date < endDate
            }
            
            return startEnabled && endEnabled
        case .oneMonth:
            return false
        }
    }
}

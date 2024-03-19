//
//  CalendarView.swift
//  DatePicker
//
//  Created by zhussupali on 29.02.2024.
//

import UIKit

protocol CalendarViewDelegate: AnyObject {
    func didSelect(date: Date)
}

final class CalendarView: UIView {
    weak var delegate: CalendarViewDelegate?
    
    private(set) var selectedDates: [Date] = []
    private(set) var appearance: DatePickerAppearance?
    private(set) var viewModel: CalendarViewModel?
    
    private let defaultCellSize: CGFloat = 46.5
    private let headerHeight: CGFloat = 24
    private lazy var heightConstraint: NSLayoutConstraint = {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
        constraint.isActive = true
        return constraint
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.headerReferenceSize = CGSize(width: collectionView.frame.size.width, height: headerHeight)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CalendarDateCollectionCell.self, forCellWithReuseIdentifier: CalendarDateCollectionCell.description())
        collectionView.register(CalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CalendarHeaderView.description())
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

extension CalendarView {
    func configure(with viewModel: CalendarViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
        updateHeight()
    }
    
    func configure(appearance: DatePickerAppearance?) {
        self.appearance = appearance
        collectionView.reloadData()
    }
    
    func configure(selectedDates dates: [Date]) {
        selectedDates = dates
        collectionView.reloadData()
    }
}

// MARK: - Private methods

private extension CalendarView {
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
    
    func updateHeight() {
        let cellSize = max(collectionView.bounds.size.width / 7.0, defaultCellSize)
        let items = (viewModel?.dates.count ?? 0) + (viewModel?.startIndex ?? 0)
        let rows = ceil(CGFloat(items) / 7.0)
        let height = headerHeight + cellSize * rows
        heightConstraint.constant = height
        print(viewModel?.month ?? "", "height:", height, items, rows, "cellSize:", cellSize)
    }
}

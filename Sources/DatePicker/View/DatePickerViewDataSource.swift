//
//  DatePickerViewDataSource.swift
//  DatePicker
//
//  Created by zhussupali on 04.03.2024.
//

import UIKit

protocol DatePickerViewDataSourceDelegate: AnyObject {
    func loadPreviousSection()
    func loadNextSection()
    func updateHeightIfNeeded()
}

final class DatePickerViewDataSource: NSObject {
    enum SelectionStyle {
        case single
        case multiple
        case range
    }
    
    weak var delegate: DatePickerViewDataSourceDelegate?
    
    private(set) var appearance = DatePickerAppearance()
    private(set) var sections: [DatePickerViewSections] = []
    private(set) var selectedDates: [Date] = []
    private var selectionStyle: SelectionStyle = .single
}

// MARK: - Public methods

extension DatePickerViewDataSource {
    func configure(sections: [DatePickerViewSections]) {
        self.sections = sections
    }
    
    func configure(selectionStyle: SelectionStyle) {
        self.selectionStyle = selectionStyle
    }
}

// MARK: - DataSource

extension DatePickerViewDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DatePickerCollectionViewCell.description(), for: indexPath) as! DatePickerCollectionViewCell
        let section = sections[indexPath.section]
        let startIndex = section.startIndex
        cell.configure(with: appearance)
        
        if indexPath.item >= startIndex {
            let date = section.dates[indexPath.item - startIndex]
            cell.label.text = date.day.description
            if selectedDates.contains(date) {
                let isEdge = selectedDates.first == date || selectedDates.last == date
                cell.setSelected(true, isEdge: isEdge)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section]
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DatePickerCollectionHeaderView.description(), for: indexPath) as! DatePickerCollectionHeaderView
            headerView.configure(with: section.month.description(in: .name) + " " + section.year.description)
            headerView.configure(appearnace: appearance)
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - Delegate

extension DatePickerViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        guard let date = section.dates[safe: indexPath.item - section.startIndex] else { return }
        switch selectionStyle {
        case .single:
            selectedDates.removeAll()
            selectedDates.append(date)
        case .multiple:
            selectedDates.append(date)
        case .range:
            if selectedDates.isEmpty {
                selectedDates.append(date)
            } else if selectedDates.count == 1 {
                let firstDate = min(selectedDates[0], date)
                let secondDate = max(selectedDates[0], date)
                selectedDates = firstDate.range(to: secondDate)
            } else {
                selectedDates.removeAll()
            }
        }
        print(selectedDates.compactMap { $0.day.description + ", " + $0.month.description(in: .name) })
        collectionView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        
        if contentOffsetY < DatePickerView.headerHeight {
            delegate?.loadPreviousSection()
        }
        
        if contentOffsetY + frameHeight >= contentHeight {
            delegate?.loadNextSection()
        }
    }
}

// MARK: - DelegateFlowLayout

extension DatePickerViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size.width / 7.0
        if DatePickerView.cellSize != size {
            DatePickerView.cellSize = size
            delegate?.updateHeightIfNeeded()
        }
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

//
//  CalendarViewDataSource.swift
//  DatePicker
//
//  Created by zhussupali on 04.03.2024.
//

import UIKit

// MARK: - DataSource

extension CalendarView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.numberOfItems ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDateCollectionCell.description(), for: indexPath) as? CalendarDateCollectionCell,
              let viewModel
        else { return UICollectionViewCell() }
        let startIndex = viewModel.startIndex
        cell.configure(with: appearance)
        
        if indexPath.item >= startIndex {
            let date = viewModel.dates[indexPath.item - startIndex]
            cell.label.text = date.day.description
            if selectedDates.contains(date) {
                let isEdge = selectedDates.first == date || selectedDates.last == date
                cell.setSelected(true, isEdge: isEdge)
            }
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewModel else { return UICollectionReusableView() }
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalendarHeaderView.description(), for: indexPath) as! CalendarHeaderView
            headerView.configure(with: viewModel.month.description(in: .name) + " " + viewModel.year.description)
            headerView.configure(appearnace: appearance)
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - Delegate

extension CalendarView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel,
              let date = viewModel.dates[safe: indexPath.item - viewModel.startIndex]
        else { return }
        delegate?.didSelect(date: date)
    }
}

// MARK: - DelegateFlowLayout

extension CalendarView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size.width / 7.0
        if self.cellSize != size {
            self.cellSize = size
            updateHeightIfNeeded()
        }
        return CGSize(width: size, height: size)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

// MARK: - Private methods

private extension CalendarView {
    func updateHeightIfNeeded() {
        let height = headerHeight + (cellSize * CGFloat(viewModel?.dates.count ?? 0) / 7) + 32
        heightConstraint.constant = height
    }
}

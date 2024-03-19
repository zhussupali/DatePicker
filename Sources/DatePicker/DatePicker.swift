// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

extension DatePicker {
    enum SelectionStyle {
        case single
        case multiple
        case range
    }
    
    enum MonthDisplayMode: Equatable {
        case oneMonth
        case monthRange(from: Date?, to: Date?)
        case allMonths
    }
}

public final class DatePicker: UIControl {
    private var items: [CalendarViewModel] = []
    private var selectedDates: [Date] = []
    private var selectionStyle: SelectionStyle = .range
    private let displayMode: MonthDisplayMode = .allMonths
    private var appearance = DatePickerAppearance()
    
    private let headerView = DatePickerHeaderView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        DispatchQueue.main.async {
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
        }
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DatePickerTableCell.self, forCellReuseIdentifier: DatePickerTableCell.description())
        return tableView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - Public methods

public extension DatePicker {
    func configure(with date: Date) {
        self.items = [.init(date: date)]
        loadPrevious()
    }
    
    func configure(appearance: (DatePickerAppearance) -> Void) {
        appearance(self.appearance)
        headerView.configure(appearance: self.appearance.header)
        tableView.reloadData()
    }
}

// MARK: - Private methods

private extension DatePicker {
    func setupView() {
        backgroundColor = .clear
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - DatePicker

extension DatePicker: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableCell.description(), for: indexPath) as! DatePickerTableCell
        cell.configure(calendar: items[indexPath.item])
        cell.configure(selectedDates: selectedDates)
        cell.configure(appearance: appearance)
        cell.delegate = self
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        
        if contentOffsetY < 20 {
            loadPrevious()
        }
        
        if contentOffsetY + frameHeight >= contentHeight {
            loadNext()
        }
    }
    
    func loadPrevious() {
        guard let date = items.first?.dates.first,
              isPagingEnabled(for: date)
        else { return }
        
        let previous = date.date(byAdding: .month, value: -1)
        items = [.init(date: previous)] + items
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(item: 1, section: 0), at: .top, animated: false)
    }
    
    func loadNext() {
        guard let date = items.last?.dates.last,
              isPagingEnabled(for: date)
        else { return }
        
        let next = date.date(byAdding: .month, value: 1)
        items = items + [.init(date: next)]
        tableView.reloadData()
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

// MARK: - DatePickerTableCellDelegate

extension DatePicker: DatePickerTableCellDelegate {
    func didSelect(date: Date) {
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
            headerView.configure(startDate: selectedDates.first?.description(.day, .month(format: .numeric), .year))
            headerView.configure(endDate: selectedDates.last?.description(.day, .month(format: .numeric), .year))
        }
        print(selectedDates.compactMap { $0.day.description + ", " + $0.month.description(in: .name) })
        tableView.reloadData()
    }
}

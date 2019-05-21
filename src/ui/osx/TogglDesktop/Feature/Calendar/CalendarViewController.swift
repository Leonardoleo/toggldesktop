//
//  CalendarViewController.swift
//  TogglDesktop
//
//  Created by Nghia Tran on 4/19/19.
//  Copyright © 2019 Alari. All rights reserved.
//

import Cocoa

protocol CalendarViewControllerDelegate: class {

    func calendarViewControllerDidSelect(date: Date)
}

final class CalendarViewController: NSViewController {

    // MARK: OUTLET

    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var popverWidth: NSLayoutConstraint!
    @IBOutlet weak var clipView: NSClipView!
    @IBOutlet weak var stackViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var dayStackView: NSStackView!

    // MARK: Variables

    weak var delegate: CalendarViewControllerDelegate?
    fileprivate lazy var dataSource: CalendarDataSource = CalendarDataSource()
    private var isViewAppearing = false
    private var selectedDate = Date()

    // MARK: View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initCommon()
        renderCalendarHeader()
        initCollectionView()
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        isViewAppearing = true
        reloadCalendarView()
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        isViewAppearing = false
    }

    // MARK: Public

    func prepareLayout(with date: Date) {
        selectedDate = date
        reloadCalendarView()
    }

    private func reloadCalendarView() {
        guard isViewAppearing else { return }
        dataSource.render(at: selectedDate)
        reloadCalendarCollectionView()
    }

    private func reloadCalendarCollectionView() {
        collectionView.reloadData()

        // Scroll to selected date
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.collectionView.scrollToItems(at: Set<IndexPath>(arrayLiteral: IndexPath(item: self.dataSource.indexForCurrentDate, section: 0)),
                                         scrollPosition: [.centeredVertically])
        }


        // Fix for the padding of scoller bar
        if let flow = collectionView.collectionViewLayout as? CalendarFlowLayout {

            // If the scroller bar is showing
            // Increase the padding
            if clipView.frame.width < 240 {
                let width = flow.collectionViewContentSize.width
                popverWidth.constant = width + 15
                stackViewTrailing.constant = 20
            }
        }
    }
}

// MARK: Private

extension CalendarViewController {

    fileprivate func initCommon() {
        dataSource.delegate = self
    }

    fileprivate func initCollectionView() {
        collectionView.register(NSNib(nibNamed: CalendarDataSource.Constants.cellNibName, bundle: nil),
                                forItemWithIdentifier: CalendarDataSource.Constants.cellID)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.collectionViewLayout = CalendarFlowLayout()
    }

    fileprivate func renderCalendarHeader() {

        // remove all
        dayStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }

        // Get the config
        let days = Calendar.current.shortStandaloneWeekdaySymbols
        let firstDayOfWeekIndex = Calendar.current.firstWeekday

        // Rotate the days since the days is started from Sun
        let rotatedDays = Array(days[firstDayOfWeekIndex-1..<days.count]) + days[0..<firstDayOfWeekIndex-1]

        // Map to label
        let labels = rotatedDays.map { title -> DayLabel in
            let label = DayLabel.xibView() as DayLabel
            label.stringValue = title.uppercased()
            return label
        }
        labels.forEach {
            dayStackView.addArrangedSubview($0)
        }
    }
}

extension CalendarViewController: CalendarDataSourceDelegate {

    func calendarDidSelect(_ date: Date) {
        delegate?.calendarViewControllerDidSelect(date: date)
    }
}

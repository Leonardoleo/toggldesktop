//
//  TimelineActivityCell.swift
//  TogglDesktop
//
//  Created by Nghia Tran on 6/21/19.
//  Copyright © 2019 Alari. All rights reserved.
//

import Cocoa

final class TimelineActivityCell: NSCollectionViewItem {

    // MARK: OUTLET

    @IBOutlet weak var backgroundView: NSBox!

    // MARK: View

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: Public

    func config(for activity: TimelineActivity) {

    }

    @IBAction func activityOnTap(_ sender: Any) {
    }
}

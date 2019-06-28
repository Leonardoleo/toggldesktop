//
//  TimelineTimeEntryHoverViewController.swift
//  TogglDesktop
//
//  Created by Nghia Tran on 6/28/19.
//  Copyright © 2019 Alari. All rights reserved.
//

import Cocoa

class TimelineTimeEntryHoverViewController: NSViewController {

    // MARK: OUTLET

    @IBOutlet weak var startEndTimeLbl: NSTextField!
    @IBOutlet weak var durationLbl: NSTextField!
    @IBOutlet weak var descriptionLbl: NSTextField!
    @IBOutlet weak var projectLbl: ProjectTextField!
    @IBOutlet weak var dotImageView: DotImageView!
    @IBOutlet weak var clientLbl: NSTextField!
    @IBOutlet weak var stackView: NSStackView!
    @IBOutlet weak var tagImageView: NSImageView!
    @IBOutlet weak var billableImageView: NSImageView!

    // MARK: Variables

    private var timeEntry: TimelineTimeEntry!

    // MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Public

    func render(with timeEntry: TimelineTimeEntry) {
        self.timeEntry = timeEntry
        let item = timeEntry.timeEntry

        startEndTimeLbl.stringValue = "\(item.startTimeString ?? "") - \(item.endTimeString ?? "")"
        durationLbl.stringValue = item.duration
        tagImageView.isHidden = item.tags?.isEmpty ?? true
        billableImageView.isHidden = !item.billable
        if let description = item.descriptionName, !description.isEmpty {
            descriptionLbl.stringValue = description
            descriptionLbl.toolTip = description
        } else {
            descriptionLbl.stringValue = "No Description"
            descriptionLbl.toolTip = nil
        }

        // Projects
        if let project = item.projectLabel, !project.isEmpty {
            if let color = ConvertHexColor.hexCode(toNSColor: item.projectColor) {
                dotImageView.isHidden = false
                dotImageView.fill(with: color)
                projectLbl.textColor = color
            } else {
                dotImageView.isHidden = true
                projectLbl.textColor = NSColor.labelColor
            }
            projectLbl.stringValue = project
        } else {
            dotImageView.isHidden = true
            projectLbl.stringValue = "No Project"
            projectLbl.toolTip = nil
        }

        // Client
        clientLbl.stringValue = item.clientLabel
    }
}

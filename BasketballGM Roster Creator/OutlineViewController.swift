//
//  OutlineViewController.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation
import Cocoa

class OutlineViewController: NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource {
    let outlineItems: [String] = ["Players", "Teams"]

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return outlineItems[index]
    }

    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return outlineItems.count
    }

    func outlineView(_ outlineView: NSOutlineView, viewFor viewForTableColumn: NSTableColumn?, item: Any) -> NSView? {
        let view = outlineView.make(withIdentifier: "DataCell", owner: self) as! NSTableCellView

        view.textField?.stringValue = item as! String

        return view
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }

    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        return false
    }

    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let outlineView = notification.object as? NSOutlineView else { return }
        let selectedIndex = outlineView.selectedRow

        switch selectedIndex {
        case 0:
            print("Edit players")
        case 1:
            print("Edit teams")
        case 2:
            print("Edit game values")
        default:
            assertionFailure()
        }
    }
}

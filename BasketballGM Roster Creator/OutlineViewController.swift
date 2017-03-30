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
    private var window: MainWindowController {
        return view.window?.windowController as! MainWindowController
    }

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

    override func viewDidAppear() {
        super.viewDidAppear()

        selectFirstItem()
    }

    /// To select "Players" on first load.
    private func selectFirstItem() {
        // Would like to have this in viewDidLoad but certain things
        // aren't fully loaded yet so it doesn't quite work as well.
        // revisit later.

        let index = IndexSet(integer: 0)
        let outlineView = sourceItemView as? NSOutlineView

        outlineView?.selectRowIndexes(index, byExtendingSelection: false)
    }

    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let outlineView = notification.object as? NSOutlineView else { return }
        let selectedIndex = outlineView.selectedRow

        switch selectedIndex {
        case 0:
            print("Edit players")
            window.refreshCollectionView(contentMode: .players)
        case 1:
            print("Edit teams")
            window.refreshCollectionView(contentMode: .teams)
        case 2:
            print("Edit game values")
        default:
            assertionFailure()
        }
    }
}

//
//  MainWindowController.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/28/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        configureWindowAppearance()
        setContentViewController()
    }

    private func configureWindowAppearance() {
        if let window = window {
            if let view = window.contentView {
                view.wantsLayer = true
            }
        }
    }

    private func setContentViewController() {
        let splitViewController = NSSplitViewController()
        splitViewController.splitView.dividerStyle = .thin

        if let sideBarController = storyboard?.instantiateController(withIdentifier: "outlineViewController") as? OutlineViewController {
            let sideBarSplitView = NSSplitViewItem(viewController: sideBarController)
            splitViewController.addSplitViewItem(sideBarSplitView)
        }

        if  let itemListController = storyboard?.instantiateController(withIdentifier: "itemListCollectionViewController") as? ItemListCollectionViewController {
            let itemSplitView = NSSplitViewItem(viewController: itemListController)
            splitViewController.addSplitViewItem(itemSplitView)
        }

        if let playerDetailViewController = storyboard?.instantiateController(withIdentifier: "playerDetailViewController") as? PlayerDetailViewController {
            let playerDetailsplitView = NSSplitViewItem(viewController: playerDetailViewController)
            splitViewController.addSplitViewItem(playerDetailsplitView)
        }

        contentViewController = splitViewController
    }

    @IBAction func openDocument(_ sender: Any?) {
        let panel = NSOpenPanel()

        guard let window = window else { return }

        panel.beginSheetModal(for: window) { result in
            if result == NSFileHandlingPanelOKButton {
                guard let url = panel.urls.first else { return }

                API.shared.getRosterFrom(url) {
                    self.refreshCollectionViewWith(.players)
                }
            }
        }
    }

    func refreshCollectionViewWith(_ contentMode: ContentMode) {
        ((self.contentViewController as? NSSplitViewController)?.childViewControllers[1] as? ItemListCollectionViewController)?.refreshCollectionViewWith(contentMode)
    }
}

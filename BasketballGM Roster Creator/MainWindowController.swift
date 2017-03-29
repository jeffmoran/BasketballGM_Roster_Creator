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
        splitViewController.splitView.dividerStyle = .thick

        let sideBarController = storyboard?.instantiateController(withIdentifier: "outlineViewController") as! OutlineViewController
        let itemListController = storyboard?.instantiateController(withIdentifier: "itemListCollectionViewController") as! ItemListCollectionViewController

        let playerDetailViewController = storyboard?.instantiateController(withIdentifier: "playerDetailViewController") as! PlayerDetailViewController

        let sideBarSplitView = NSSplitViewItem(viewController: sideBarController)
        let itemSplitView = NSSplitViewItem(viewController: itemListController)
        let playerDetailsplitView = NSSplitViewItem(viewController: playerDetailViewController)

        splitViewController.addSplitViewItem(sideBarSplitView)
        splitViewController.addSplitViewItem(itemSplitView)
        splitViewController.addSplitViewItem(playerDetailsplitView)

        contentViewController = splitViewController
    }

    @IBAction func openDocument(_ sender: Any?) {
        let panel = NSOpenPanel()

        panel.begin { result in
            if result == NSFileHandlingPanelOKButton {
                guard let url = panel.urls.first else { return }

                guard let data = NSData(contentsOf: url) as Data? else { return }

                do {
                    guard let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }

                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

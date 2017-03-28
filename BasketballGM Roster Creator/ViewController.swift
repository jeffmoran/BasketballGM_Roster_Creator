//
//  ViewController.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true

        // Do any additional setup after loading the view.s
    }

    override func viewDidAppear() {
        super.viewDidAppear()

        view.layer?.backgroundColor = NSColor.blue.cgColor
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
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

    @IBAction func saveDocument(_ sender: Any?) {
        print("SAVING!")
    }
}


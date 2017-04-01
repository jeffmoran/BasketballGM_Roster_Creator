//
//  PlayerCollectionViewItem.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/28/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class PlayerCollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var playerName: NSTextField!
    @IBOutlet weak var playerTeamName: NSTextField!
    @IBOutlet weak var playerProfileImageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.red.cgColor
        view.layer?.borderColor = NSColor.blue.cgColor
        view.layer?.borderWidth = 5.0
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        playerProfileImageView.image = nil
    }
    
}

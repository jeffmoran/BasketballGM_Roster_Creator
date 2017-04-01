//
//  PlayerCollectionViewItem.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/28/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class PlayerCollectionViewItem: NSCollectionViewItem {

    var player: Player? {
        didSet {
            guard let player = player else { return }

            let playerTmRegion = player.team?.region ?? "Free"
            let playerTmName = player.team?.name ?? "Agent"

            playerName.stringValue = player.name
            playerProfileImageView.downloadedFrom(link: player.profileURL)
            playerTeamName.stringValue = playerTmRegion + " " + playerTmName
        }
    }

    @IBOutlet weak private var playerName: NSTextField!
    @IBOutlet weak private var playerTeamName: NSTextField!
    @IBOutlet weak private var playerProfileImageView: NSImageView!

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

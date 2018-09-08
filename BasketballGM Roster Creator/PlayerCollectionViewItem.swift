//
//  PlayerCollectionViewItem.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/28/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class PlayerCollectionViewItem: BaseCollectionViewItem {

    var player: Player? {
        didSet {
            guard let player = player else { return }

            let playerTmRegion = player.team?.region ?? "Free"
            let playerTmName = player.team?.name ?? "Agent"

            playerName.stringValue = player.name ?? ""
            playerProfileImageView.downloadedFrom(link: player.imgURL)
            playerTeamName.stringValue = playerTmRegion + " " + playerTmName
        }
    }

    @IBOutlet private weak var playerName: NSTextField!
    @IBOutlet private weak var playerTeamName: NSTextField!
    @IBOutlet private weak var playerProfileImageView: NSImageView!

    override func prepareForReuse() {
        super.prepareForReuse()

        playerProfileImageView.image = nil
    }
}

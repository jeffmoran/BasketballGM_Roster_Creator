//
//  TeamCollectionViewItem.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/29/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class TeamCollectionViewItem: BaseCollectionViewItem {

    var team: Team? {
        didSet {
            guard let team = team else { return }

            teamName.stringValue = team.fullTeamName
            teamImageView.downloadedFrom(link: team.imageURL)
        }
    }

    @IBOutlet weak private var teamName: NSTextField!
    @IBOutlet weak private var teamImageView: NSImageView!

    override func prepareForReuse() {
        super.prepareForReuse()

        teamImageView.image = nil
    }
}

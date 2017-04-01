//
//  TeamCollectionViewItem.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/29/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class TeamCollectionViewItem: NSCollectionViewItem {

    var team: Team? {
        didSet {
            guard let team = team else { return }

            teamName.stringValue = team.name
            teamImageView.downloadedFrom(link: team.imageURL)
        }
    }

    @IBOutlet weak private var teamName: NSTextField!
    @IBOutlet weak private var teamImageView: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.red.cgColor
        view.layer?.borderColor = NSColor.blue.cgColor
        view.layer?.borderWidth = 5.0
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        teamImageView.image = nil
    }

}

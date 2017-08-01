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

            teamName.stringValue = team.fullTeamName
            teamImageView.downloadedFrom(link: team.imageURL)
        }
    }

    @IBOutlet weak private var teamName: NSTextField!
    @IBOutlet weak private var teamImageView: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

		view.wantsLayer = true
		view.layer?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		view.layer?.borderColor = #colorLiteral(red: 0.06659137458, green: 0.4527410865, blue: 0.698549211, alpha: 1)
		view.layer?.borderWidth = 3.0
		view.layer?.cornerRadius = 15.0
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        teamImageView.image = nil
    }
}

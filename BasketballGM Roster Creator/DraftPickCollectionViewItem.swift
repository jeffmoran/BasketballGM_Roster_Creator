//
//  DraftPickCollectionViewItem.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/24/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class DraftPickCollectionViewItem: NSCollectionViewItem {

	var draftPick: DraftPick? {
		didSet {
			guard let draftPick = draftPick else { return }

			guard let team = API.shared.getTeamWith(draftPick.teamID) else { return }
			guard let originalTeam = API.shared.getTeamWith(draftPick.originalTeamID) else { return }

			self.team.stringValue = team.fullTeamName
		}
	}

	@IBOutlet weak private var team: NSTextField!

	override func viewDidLoad() {
		super.viewDidLoad()

		view.wantsLayer = true
		view.layer?.backgroundColor = NSColor.red.cgColor
		view.layer?.borderColor = NSColor.blue.cgColor
		view.layer?.borderWidth = 5.0
	}

	override func prepareForReuse() {
		super.prepareForReuse()
	}

}

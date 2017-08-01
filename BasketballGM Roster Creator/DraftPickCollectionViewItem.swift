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
		view.layer?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		view.layer?.borderColor = #colorLiteral(red: 0.06659137458, green: 0.4527410865, blue: 0.698549211, alpha: 1)
		view.layer?.borderWidth = 3.0
		view.layer?.cornerRadius = 15.0
	}

	override func prepareForReuse() {
		super.prepareForReuse()
	}
}

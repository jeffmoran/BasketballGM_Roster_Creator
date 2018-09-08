//
//  DraftPickCollectionViewItem.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/24/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class DraftPickCollectionViewItem: BaseCollectionViewItem {

	var draftPick: DraftPick? {
		didSet {
			guard let draftPick = draftPick else { return }

			guard let destinationTeam = API.shared.getTeamWith(draftPick.tid) else { return }
			guard let originalTeam = API.shared.getTeamWith(draftPick.originalTid) else { return }

			originalTeamImageView.downloadedFrom(link: originalTeam.imgURL)
			newTeamImageView.downloadedFrom(link: destinationTeam.imgURL)

			draftPickDescription.stringValue = draftPick.descriptionString
		}
	}

	@IBOutlet weak private var draftPickDescription: NSTextField!
	@IBOutlet weak private var originalTeamImageView: NSImageView!
	@IBOutlet weak private var newTeamImageView: NSImageView!

	override func prepareForReuse() {
		super.prepareForReuse()
	}
}

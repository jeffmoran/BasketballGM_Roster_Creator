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

			originalTeamImageView.downloadedFrom(link: draftPick.originalTeam.imgURL)
			newTeamImageView.downloadedFrom(link: draftPick.destinationTeam.imgURL)

			draftPickDescription.stringValue = draftPick.descriptionString
		}
	}

	@IBOutlet private weak var draftPickDescription: NSTextField!
	@IBOutlet private weak var originalTeamImageView: NSImageView!
	@IBOutlet private weak var newTeamImageView: NSImageView!

}

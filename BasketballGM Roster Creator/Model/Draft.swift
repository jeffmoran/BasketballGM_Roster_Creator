//
//  Draft.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/3/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct DraftPick: Codable {
	var tid: Int
	var round: Int
	var pick: Int
	var originalTid: Int
	var season: Int?
	var year: Int?

	var descriptionString: String {
		guard let originalTeam = originalTeam else { return "" }
		guard let destinationTeam = destinationTeam else { return "" }
		guard let season = season else { return "" }

		let suffix: String = round == 1 ? "st" : "nd"

		let string = "\(originalTeam.abbrev) \(season) \(round)\(suffix) round pick"

		if originalTeam == destinationTeam {
			return string
		} else {
			return string + " round pick to \(destinationTeam.abbrev)"
		}
	}

	var originalTeam: Team! {
		return API.shared.getTeamAt(originalTid)
	}

	var destinationTeam: Team! {
		return API.shared.getTeamAt(tid)
	}
}

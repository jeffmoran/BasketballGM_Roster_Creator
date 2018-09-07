//
//  Draft.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/3/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct DraftPick: Decodable {
	var tid: Int
	var round: Int
	var pick: Int
	var originalTid: Int
	var season: Int?
	var year: Int?
	
	var descriptionString: String {
		guard let originalTeam = originalTeam else { return "" }
		guard let destinationTeam = destinationTeam else { return "" }

		let suffix: String = round == 1 ? "st" : "nd"

		return "\(originalTeam.abbreviation) \(season) \(round)\(suffix) round pick to \(destinationTeam.abbreviation)"
	}

	var originalTeam: Team! {
		return API.shared.getTeamAt(originalTid)
	}

	var destinationTeam: Team! {
		return API.shared.getTeamAt(tid)
	}
}

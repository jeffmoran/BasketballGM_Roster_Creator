//
//  Draft.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/3/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct DraftPick {
	var teamID: Int
	var round: Int
	var pick: Int
	var originalTeamID: Int
	var season: Int

	init(_ draftDict: [String: Any]?) {
		self.teamID = draftDict?["tid"] as? Int ?? 0
		self.round = draftDict?["round"] as? Int ?? 0
		self.pick = draftDict?["pick"] as? Int ?? 0
		self.originalTeamID = draftDict?["originalTid"] as? Int ?? 0
		self.season = draftDict?["season"] as? Int ?? 0
	}

	var descriptionString: String {
		guard let destinationTeam = API.shared.getTeamWith(teamID) else { return "" }

		let suffix: String = round == 1 ? "st" : "nd"

		return "\(season) \(round)\(suffix) round pick to \(destinationTeam.abbreviation ?? "")"
	}
}

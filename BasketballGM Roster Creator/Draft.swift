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
	var year: Int

	init(_ draftDict: [String: Any]?) {
		self.teamID = draftDict?["tid"] as? Int ?? 0
		self.round = draftDict?["round"] as? Int ?? 0
		self.pick = draftDict?["pick"] as? Int ?? 0
		self.originalTeamID = draftDict?["originalTid"] as? Int ?? 0
		self.year = draftDict?["year"] as? Int ?? 0
	}
}

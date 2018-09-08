//
//  League.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/29/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct League: Decodable {
	//	var rawDict: [String: Any]
	var startingSeason: Int = 2018
	var teams: [Team] = [Team]()
	var players: [Player] = [Player]()
	var draftPicks: [DraftPick] = [DraftPick]()

	mutating func addFakeTeams() {
		teams.insert(Team.freeAgentTeam, at: 0)
		teams.insert(Team.upcomingCurrentDraftProspectTeam(with: startingSeason), at: 1)
		teams.insert(Team.nextYearDraftProspectTeam(with: startingSeason), at: 2)
		teams.insert(Team.nextNextYearDraftProspectTeam(with: startingSeason), at: 3)
		teams.insert(Team.retiredPlayersTeam, at: 4)
	}
}

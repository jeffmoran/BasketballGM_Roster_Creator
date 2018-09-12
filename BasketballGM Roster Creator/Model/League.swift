//
//  League.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/29/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct League: Codable {
	var startingSeason: Int
	var teams: [Team]
	var players: [Player]
	var draftPicks: [DraftPick]
	var gameAttributes: [GameAttributes]

	mutating func addFakeTeams() {
		teams.insert(Team.freeAgentTeam, at: 0)
		teams.insert(Team.upcomingCurrentDraftProspectTeam(with: startingSeason), at: 1)
		teams.insert(Team.nextYearDraftProspectTeam(with: startingSeason), at: 2)
		teams.insert(Team.nextNextYearDraftProspectTeam(with: startingSeason), at: 3)
		teams.insert(Team.retiredPlayersTeam, at: 4)
	}

	mutating func update(_ players: [Player]) {
		self.players = players.enumerated().map { index, player in
			var player = player
			player.playerID = index

			return player
		}
	}
}

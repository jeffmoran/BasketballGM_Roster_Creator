//
//  Roster.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/29/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct Roster {
	var rawDict: [String: Any]
	var startingSeason: Int = 2018
    var teams: [Team] = [Team]()
    var players: [Player] = [Player]()
	var draftPicks: [DraftPick]?

    init(_ jsonDict: [String: Any]) {
		rawDict = jsonDict

        guard let jsonTeams = jsonDict["teams"] as? [[String: Any]] else { fatalError("Bad JSON, no teams found?") }
        guard let jsonPlayers = jsonDict["players"] as? [[String: Any]] else { fatalError("Bad JSON, no players found?") }
		let jsonDraftPicks = jsonDict["draftPicks"] as? [[String: Any]] ?? []

		if let startingSeason = jsonDict["startingSeason"] as? Int {
			self.startingSeason = startingSeason
		}

		teams.append(Team.freeAgentTeam)
		teams.append(Team.upcomingCurrentDraftProspectTeam(with: startingSeason))
		teams.append(Team.nextYearDraftProspectTeam(with: startingSeason))
		teams.append(Team.nextNextYearDraftProspectTeam(with: startingSeason))
		teams.append(Team.retiredPlayersTeam)

		jsonTeams.forEach {
			teams.append(Team($0))
		}

        for (index, playerDict) in jsonPlayers.enumerated() {
			var player = Player(playerDict)
			player.playerID = index

            players.append(player)
        }

		let decoder = JSONDecoder()

		do {
			let jsonData = try JSONSerialization.data(withJSONObject: jsonDraftPicks, options: [])
			let draftPicks = try decoder.decode([DraftPick].self, from: jsonData)

			self.draftPicks = draftPicks
		} catch {
			fatalError(error.localizedDescription)
		}
    }

	func asDictionary() -> [String: Any] {
		return rawDict
	}
}

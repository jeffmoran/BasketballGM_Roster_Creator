//
//  Roster.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/29/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct Roster {
	var rawJSONDict: [String: Any] = [String: Any]()
    var teams: [Team] = [Team]()
    var players: [Player] = [Player]()
	var draftPicks: [DraftPick] = [DraftPick]()

    init(_ jsonDict: [String: Any]) {
        guard let jsonTeams = jsonDict["teams"] as? [[String: Any]] else { return }
        guard let jsonPlayers = jsonDict["players"] as? [[String: Any]] else { return }
		guard let jsonDraftPicks = jsonDict["draftPicks"] as? [[String: Any]] else { return }

        for team in jsonTeams {
            teams.append(Team(team))
        }

        for (index, playerDict) in jsonPlayers.enumerated() {
			var player = Player(playerDict)
			player.playerID = index

            players.append(player)
        }

		for draftPick in jsonDraftPicks {
			draftPicks.append(DraftPick(draftPick))
		}
    }
}

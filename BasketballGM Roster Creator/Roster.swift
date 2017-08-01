//
//  Roster.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/29/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct Roster {
    var teams: [Team] = [Team]()
    var players: [Player] = [Player]()
	var draftPicks: [DraftPick] = [DraftPick]()

    init(_ jsonDict: [String: Any]) {
        guard let jsonTeams = jsonDict["teams"] as? [[String: Any]] else { return }
        guard let jsonPlayers = jsonDict["players"] as? [[String: Any]] else { return }
		let jsonDraftPicks = jsonDict["draftPicks"] as? [[String: Any]]

        for team in jsonTeams {
            teams.append(Team(team))
        }

        for (index, playerDict) in jsonPlayers.enumerated() {
			var player = Player(playerDict)
			player.playerID = index

            players.append(player)
        }

		if let jsonDraftPicks = jsonDraftPicks {
			for draftPick in jsonDraftPicks {
				draftPicks.append(DraftPick(draftPick))
			}
		}
    }
}

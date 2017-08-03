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
    var teams: [Team] = [Team]()
    var players: [Player] = [Player]()
	var draftPicks: [DraftPick] = [DraftPick]()

    init(_ jsonDict: [String: Any]) {
		rawDict = jsonDict

        guard let jsonTeams = jsonDict["teams"] as? [[String: Any]] else { return }
        guard let jsonPlayers = jsonDict["players"] as? [[String: Any]] else { return }
		let jsonDraftPicks = jsonDict["draftPicks"] as? [[String: Any]]

		jsonTeams.forEach {
			teams.append(Team($0))
		}

        for (index, playerDict) in jsonPlayers.enumerated() {
			var player = Player(playerDict)
			player.playerID = index

            players.append(player)
        }

		if let jsonDraftPicks = jsonDraftPicks {
			jsonDraftPicks.forEach {
				draftPicks.append(DraftPick($0))
			}
		}
    }

	func asDictionary() -> [String: Any] {
		return rawDict
	}
}

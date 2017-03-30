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

    init(_ jsonDict: [String: Any]) {
        let jsonTeams =  jsonDict["teams"] as? [[String: Any]]
        let jsonPlayers =  jsonDict["players"] as? [[String: Any]]

        for team in jsonTeams! {
            teams.append(Team(team))
        }

        for player in jsonPlayers! {
            players.append(Player(player))
        }        
    }
}

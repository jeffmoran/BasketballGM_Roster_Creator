//
//  Player.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

enum Position: String {
    case pointGuard, shootingGuard, smallForward, powerForward, center
}

struct Player {
    var name: String
    var teamID: Int
//    var position: Position!
    var height: Int
    var weight: Int
    var profileURL: String

    init(_ jsonDict: [String: Any]? = nil) {
        self.name = jsonDict?["name"] as? String ?? ""
        self.height = jsonDict?["hgt"] as? Int ?? 0
        self.weight = jsonDict?["weight"] as? Int ?? 0
        self.profileURL = jsonDict?["imgURL"] as? String ?? ""
        self.teamID = jsonDict?["tid"] as? Int ?? -1
    }

    var team: Team? {
        return API.shared.getTeamWith(teamID)
    }
}

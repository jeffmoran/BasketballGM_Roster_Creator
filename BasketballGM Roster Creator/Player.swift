//
//  Player.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

enum Position: String {
    case pg, sg, sf, pf, c
}

struct Player {
    var name: String!
//    var team: Team!
//    var position: Position!
    var height: Int!
    var weight: Int!
//    var profileURL: String!

    init(_ jsonDict: [String: Any]? = nil) {
        self.name = jsonDict?["name"] as! String
        self.height = jsonDict?["hgt"] as? Int ?? 0
        self.weight = jsonDict?["weight"] as? Int ?? 0
    }
}

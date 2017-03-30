//
//  Team.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct Team {
    var teamID: Int
    var conferenceID: Int
    var divisionID: Int
    var region: String
    var name: String
    var abbreviation: String
    var population: Int
    var strategy: String //enum?

    init(_ jsonDict: [String: Any]) {
        self.teamID = jsonDict["tid"] as! Int
        self.conferenceID = jsonDict["cid"] as! Int
        self.divisionID = jsonDict["did"] as! Int
        self.region = jsonDict["region"] as! String
        self.name = jsonDict["name"] as! String
        self.abbreviation = jsonDict["abbrev"] as! String
        self.population = jsonDict["pop"] as! Int
        self.strategy = jsonDict["strategy"] as! String
    }
}

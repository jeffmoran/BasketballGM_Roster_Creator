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
    var abbreviation: String?
    var population: Int
    var strategy: String? //enum?
    var imageURL: String

    init(_ jsonDict: [String: Any]) {
        self.teamID = jsonDict["tid"] as? Int ?? -1
        self.conferenceID = jsonDict["cid"] as? Int ?? -1
        self.divisionID = jsonDict["did"] as? Int ?? -1
        self.region = jsonDict["region"] as? String ?? ""
        self.name = jsonDict["name"] as? String ?? ""
        self.abbreviation = jsonDict["abbrev"] as? String
        self.population = jsonDict["pop"] as? Int ?? 0
        self.strategy = jsonDict["strategy"] as? String
        self.imageURL = jsonDict["imgURL"] as? String ?? ""
    }
}

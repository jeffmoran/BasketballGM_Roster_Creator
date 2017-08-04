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
    private var population: Double
    var strategy: String
    var imageURL: String

    init(_ jsonDict: [String: Any]) {
        self.teamID = jsonDict["tid"] as? Int ?? -1
        self.conferenceID = jsonDict["cid"] as? Int ?? -1
        self.divisionID = jsonDict["did"] as? Int ?? -1
        self.region = jsonDict["region"] as? String ?? ""
        self.name = jsonDict["name"] as? String ?? ""
        self.abbreviation = jsonDict["abbrev"] as? String ?? ""
        self.population = jsonDict["pop"] as? Double ?? 0.0
        self.strategy = jsonDict["strategy"] as? String ?? ""
        self.imageURL = jsonDict["imgURL"] as? String ?? ""
    }

	static var freeAgentTeam: Team {
		return Team(["": ""])
	}

	var fullTeamName: String {
		return region + " " + name
	}

	var populationString: String {
		return String(population * 1000000)
	}

	static var allTeamsString: [String] {
		guard let allTeams = API.shared.getAllTeams() else { return [""] }

		return allTeams.map { $0.fullTeamName }
	}

	static var allConferences: [String] {
		return ["Eastern", "Western"]
	}

	static var allDivisions: [String] {
		return ["Atlantic", "Central", "Southeast", "Southwest", "Northwest", "Pacific"]
	}
}

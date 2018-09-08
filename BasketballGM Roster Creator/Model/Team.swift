//
//  Team.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct Team: Decodable, Equatable {
	// TODO: CodingKeys

    var tid: Int // teamId
    var cid: Int // conferenceId
    var did: Int // divisionId
    var region: String
    var name: String
    var abbrev: String // abbreviation
    private var pop: Double // populaiton
    var strategy: String
    var imgURL: String

    private init(_ jsonDict: [String: Any]) {
        self.tid = jsonDict["tid"] as? Int ?? -1
        self.cid = jsonDict["cid"] as? Int ?? -1
        self.did = jsonDict["did"] as? Int ?? -1
        self.region = jsonDict["region"] as? String ?? ""
        self.name = jsonDict["name"] as? String ?? ""
        self.abbrev = jsonDict["abbrev"] as? String ?? ""
        self.pop = jsonDict["pop"] as? Double ?? 0.0
        self.strategy = jsonDict["strategy"] as? String ?? ""
        self.imgURL = jsonDict["imgURL"] as? String ?? ""
    }

	static var freeAgentTeam: Team {
		var teamDict: [String: Any] = [String: Any]()
		teamDict["tid"] = -1
		teamDict["region"] = "Free"
		teamDict["name"] = "Agent"

		return Team(teamDict)
	}

	static func upcomingCurrentDraftProspectTeam(with startingSeason: Int) -> Team {
		var teamDict: [String: Any] = [String: Any]()
		teamDict["tid"] = -2
		teamDict["region"] = String(describing: startingSeason)
		teamDict["name"] = "Draft Prospect"

		return Team(teamDict)
	}

	static var retiredPlayersTeam: Team {
		var teamDict: [String: Any] = [String: Any]()
		teamDict["tid"] = -3
		teamDict["region"] = "Retired"

		return Team(teamDict)
	}

	static func nextYearDraftProspectTeam(with startingSeason: Int) -> Team {
		var teamDict: [String: Any] = [String: Any]()
		teamDict["tid"] = -4
		teamDict["region"] = String(describing: startingSeason + 1)
		teamDict["name"] = "Draft Prospect"

		return Team(teamDict)
	}

	static func nextNextYearDraftProspectTeam(with startingSeason: Int) -> Team {
		var teamDict: [String: Any] = [String: Any]()
		teamDict["tid"] = -5
		teamDict["region"] = String(describing: startingSeason + 2)
		teamDict["name"] = "Draft Prospect"

		return Team(teamDict)
	}

	var fullTeamName: String {
		return region + " " + name
	}

	var populationString: String {
		return String(pop * 1000000)
	}

	static var allTeamsString: [String] {
		guard let allTeams = API.shared.getAllTeams(includingFakeTeams: true) else { return [""] }

		return allTeams.map { $0.fullTeamName }
	}

	static var allConferences: [String] {
		return ["Eastern", "Western"]
	}

	static var allDivisions: [String] {
		return ["Atlantic", "Central", "Southeast", "Southwest", "Northwest", "Pacific"]
	}
}

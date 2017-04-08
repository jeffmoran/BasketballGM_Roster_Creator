//
//  Player.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

enum Position: String {
	case pointGuard = "PG"
	case shootingGuard = "SG"
	case smallForward = "SF"
	case powerForward = "PF"
	case center = "C"
	case `guard` = "G"
	case guardForward = "GF"
	case forward = "F"
	case forwardCenter = "FC"

	static var allPositions: [String] {
		return ["PG", "SG", "SF", "PF", "C", "G", "GF", "F", "FC"]
	}
}

struct Player {
	var name: String
	var teamID: Int
	var position: Position!
	var height: Int
	var weight: Int
	var profileURL: String
	var born: [String: Any]
	var draft: Draft
	var injury: Injury
	var college: String

	init(_ jsonDict: [String: Any]? = nil) {
		self.name = jsonDict?["name"] as? String ?? ""
		self.height = jsonDict?["hgt"] as? Int ?? 0
		self.weight = jsonDict?["weight"] as? Int ?? 0
		self.profileURL = jsonDict?["imgURL"] as? String ?? ""
		self.teamID = jsonDict?["tid"] as? Int ?? -1

		let position = jsonDict?["pos"] as? String ?? ""
		self.position = Position(rawValue: (position))

		self.born = jsonDict?["born"] as? [String: Any] ?? [:]

		self.college = jsonDict?["college"] as? String ?? ""

		let draft = jsonDict?["draft"] as? [String: Any] ?? [:]
		self.draft = Draft(draft)

		let injury = jsonDict?["injury"] as? [String: Any] ?? [:]
		self.injury = Injury(injury)
	}

	var team: Team? {
		return API.shared.getTeamWith(teamID)
	}

	var age: Int {
		let playerBornYear = born["year"] as? Int ?? 0

		let date = Date()
		let calendar = Calendar.current
		let currentYear = calendar.component(.year, from: date)

		return currentYear - playerBornYear
	}

	var hometown: String {
		return born ["loc"] as? String ?? ""
	}
}

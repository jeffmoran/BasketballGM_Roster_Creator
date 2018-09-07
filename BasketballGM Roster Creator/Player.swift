//
//  Player.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

enum Position: String, Decodable {
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
	var playerID: Int?
	var name: String
	var teamID: Int
	var position: Position?
	var height: Int
	var weight: Int
	var profileURL: String
	var born: [String: Any]
	var draft: DraftPick
	var injury: Injury
	var college: String
	var contract: Contract
	var ratings: Ratings

	init(_ jsonDict: [String: Any]? = nil) {
		let decoder = JSONDecoder()

		self.name = jsonDict?["name"] as? String ?? ""
		self.height = jsonDict?["hgt"] as? Int ?? 0
		self.weight = jsonDict?["weight"] as? Int ?? 0
		self.profileURL = jsonDict?["imgURL"] as? String ?? ""
		self.teamID = jsonDict?["tid"] as? Int ?? -1

		let position = jsonDict?["pos"] as? String ?? ""
		self.position = Position(rawValue: (position))

		self.born = jsonDict?["born"] as? [String: Any] ?? [:]

		self.college = jsonDict?["college"] as? String ?? ""

		let draftDict = jsonDict?["draft"] as? [String: Any] ?? [:]
		let injuryDict = jsonDict?["injury"] as? [String: Any] ?? [:]
		let contractDict = jsonDict?["contract"] as? [String: Any] ?? [:]
		let ratingsDict = jsonDict?["ratings"] as? [[String: Any]] ?? [[:]]

		do {
			let draftJsonData = try JSONSerialization.data(withJSONObject: draftDict, options: [])
			let injuryJsonData = try JSONSerialization.data(withJSONObject: injuryDict, options: [])
			let contractJsonData = try JSONSerialization.data(withJSONObject: contractDict, options: [])
			let ratingsJsonData = try JSONSerialization.data(withJSONObject: ratingsDict.first ?? [:], options: [])

			let draftPick = try decoder.decode(DraftPick.self, from: draftJsonData)
			let injury = try decoder.decode(Injury.self, from: injuryJsonData)
			let ratings = try decoder.decode(Ratings.self, from: ratingsJsonData)
			let contract = try decoder.decode(Contract.self, from: contractJsonData)

			self.draft = draftPick
			self.injury = injury
			self.ratings = ratings
			self.contract = contract
		} catch {
			print(error)
			print(self.name)
			fatalError(error.localizedDescription)
		}
	}

	var team: Team? {
		return API.shared.getTeamWith(teamID)
	}

	var age: Int {
		get {
			let date = Date()
			let calendar = Calendar.current
			let currentYear = calendar.component(.year, from: date)

			let playerBornYear = born["year"] as? Int ?? 0

			return currentYear - playerBornYear
		}
		set {
			let date = Date()
			let calendar = Calendar.current
			let currentYear = calendar.component(.year, from: date)

			born["year"] = currentYear - newValue
		}
	}

	var hometown: String {
		get {
			return born ["loc"] as? String ?? ""
		}
		set {
			born["loc"] = newValue
		}
	}

	func asDictionary() -> [String: Any] {
		var dict = [String: Any]()

		dict["tid"] = self.teamID
		dict["name"] = self.name
		dict["pos"] = self.position?.rawValue

		// TODO: - Add rest of player properties here

		return dict
	}
}

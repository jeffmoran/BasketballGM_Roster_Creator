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

struct Born: Decodable {
	// TODO: CodingKeys
	var year: Int
	var loc: String
}

struct Player: Decodable {
	// TODO: CodingKeys
	var playerID: Int!
	var name: String?
	var firstName: String?
	var lastName: String?
	var tid: Int
	var pos: Position
	var hgt: Int
	var weight: Int
	var imgURL: String
	var born: Born
	var draft: DraftPick
	var injury: Injury!
	var college: String
	var contract: Contract
	private var ratings: [Ratings]!

	var team: Team? {
		return API.shared.getTeamWith(tid)
	}

	var age: Int {
		get {
			let date = Date()
			let calendar = Calendar.current
			let currentYear = calendar.component(.year, from: date)

			return currentYear - born.year
		}
		set {
			let date = Date()
			let calendar = Calendar.current
			let currentYear = calendar.component(.year, from: date)

			born.year = currentYear - newValue
		}
	}

	var hometown: String {
		get {
			return born.loc
		}
		set {
			born.loc = newValue
		}
	}

	var playerRatings: Ratings {
		get {
			guard let ratings = self.ratings.first else { fatalError("No ratings?") }
			return ratings
		} set {
			ratings = [newValue]
		}
	}
}

//
//  Player.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

enum Positions {
	static var allPositions: [String] {
		return ["PG", "SG", "SF", "PF", "C", "G", "GF", "F", "FC"]
	}
}

class Born: Codable {
	// TODO: CodingKeys
	var year: Int!
	var loc: String!
}

@objc class Player: NSObject, Codable {

	var playerCopy: Player!

	@objc var allPositions: [String] {
		return ["PG", "SG", "SF", "PF", "C", "G", "GF", "F", "FC"]
	}

	// TODO: CodingKeys
	@objc dynamic var name: String?
	@objc dynamic var firstName: String?
	@objc dynamic var lastName: String?
	private var tid: Int!
	@objc dynamic var pos: String?
	private var hgt: Int!
	private var weight: Int!
	@objc dynamic var imgURL: String!
	private var born: Born!
	@objc dynamic var draft: DraftPick!
	private var injury: Injury!
	@objc dynamic var college: String!
	private var contract: Contract!
	private var ratings: [Ratings]!

	var team: Team? {
		return API.shared.getTeamWith(tid)
	}

	// MARK: - Bindings

	@objc var teamIndex: NSNumber {
		get {
			switch tid {
			case -1: return 0 as NSNumber
			case -2: return 1 as NSNumber
			case -3: return 2 as NSNumber
			case -4: return 3 as NSNumber
			case -5: return 4 as NSNumber
			default: return tid + 5 as NSNumber
			}
		}
		set {
			switch newValue {
			case 0: tid = -1
			case 1: tid = -2
			case 2: tid = -3
			case 3: tid = -4
			case 4: tid = -5
			default: tid = newValue.intValue - 5
			}
		}
	}

	@objc var contractAmount: Double {
		get {
			return contract.amount * 1000
		}
		set {
			contract.amount = newValue / 1000
		}
	}

	@objc var contractExpiring: NSNumber {
		get {
			return contract.exp as NSNumber
		}
		set {
			contract.exp = newValue.intValue
		}
	}

	@objc var age: Int {
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

	@objc var hometown: String {
		get {
			return born.loc
		}
		set {
			born.loc = newValue
		}
	}

	@objc var playerHeight: NSNumber {
		get {
			return hgt as NSNumber
		}
		set {
			hgt = newValue.intValue
		}
	}

	@objc var playerWeight: NSNumber {
		get {
			return weight as NSNumber
		}
		set {
			weight = newValue.intValue
		}
	}

	@objc var injuryType: String {
		get {
			return injury.type
		}
		set {
			injury.type = newValue
		}
	}

	@objc var injuryGamesRemaining: NSNumber {
		get {
			return injury.gamesRemaining as NSNumber
		}
		set {
			injury.gamesRemaining = newValue.intValue
		}
	}

	@objc var playerRatings: Ratings {
		get {
			guard let ratings = self.ratings.first else { fatalError("No ratings?") }
			return ratings
		} set {
			ratings = [newValue]
		}
	}
}

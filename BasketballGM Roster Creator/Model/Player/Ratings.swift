//
//  Ratings.swift
//  BasketballGM Roster Creator
//
//  Created by Jeffrey Moran on 8/2/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

@objc class Ratings: NSObject, Codable {
	enum CodingKeys: String, CodingKey {
		case height = "hgt"
		case strength = "stre"
		case speed = "spd"
		case jumping = "jmp"
		case endurance = "endu"
		case inside = "ins"
		case dunking = "dnk"
		case freeThrow = "ft"
		case fieldGoal = "fg"
		case threePointer = "tp"
		case defensiveIq = "diq"
		case offensiveIq = "oiq"
		case dribbling = "drb"
		case passing = "pss"
		case rebounding = "reb"
//		case potential = "pot"
//		case skills = "skills"
	}

	private var height: Int!
	private var strength: Int!
	private var speed: Int!
	private var jumping: Int!
	private var endurance: Int!
	private var inside: Int!
	private var dunking: Int!
	private var freeThrow: Int!
	private var fieldGoal: Int!
	private var threePointer: Int!
	private var defensiveIq: Int!
	private var offensiveIq: Int!
	private var dribbling: Int!
	private var passing: Int!
	private var rebounding: Int!
//	var potential: Int
//	private var skills: [String]

	var skillsString: String {
		get {
			return "" //skills.joined(separator: ", ")
		}
		set {
//			skills = newValue.components(separatedBy: ", ")
		}
	}

	// MARK: - Bindings

	@objc var playerHeight: NSNumber {
		get {
			return height as NSNumber
		}
		set {
			height = newValue.intValue
		}
	}
}

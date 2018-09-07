//
//  Ratings.swift
//  BasketballGM Roster Creator
//
//  Created by Jeffrey Moran on 8/2/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct Ratings: Decodable {
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

	var height: Int
	var strength: Int
	var speed: Int
	var jumping: Int
	var endurance: Int
	var inside: Int
	var dunking: Int
	var freeThrow: Int
	var fieldGoal: Int
	var threePointer: Int
	var defensiveIq: Int
	var offensiveIq: Int
	var dribbling: Int
	var passing: Int
	var rebounding: Int
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
}

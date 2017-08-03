//
//  Ratings.swift
//  BasketballGM Roster Creator
//
//  Created by Jeffrey Moran on 8/2/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct Ratings {
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
	var blocking: Int
	var stealing: Int
	var dribbling: Int
	var passing: Int
	var rebounding: Int
	var potential: Int
	var skills: [String]

	init(_ ratingsDict: [String: Any]?) {
		height = ratingsDict?["hgt"] as? Int ?? 0
		strength = ratingsDict?["stre"] as? Int ?? 0
		speed = ratingsDict?["spd"] as? Int ?? 0
		jumping = ratingsDict?["jmp"] as? Int ?? 0
		endurance = ratingsDict?["endu"] as? Int ?? 0
		inside = ratingsDict?["ins"] as? Int ?? 0
		dunking = ratingsDict?["dnk"] as? Int ?? 0
		freeThrow = ratingsDict?["ft"] as? Int ?? 0
		fieldGoal = ratingsDict?["fg"] as? Int ?? 0
		threePointer = ratingsDict?["tp"] as? Int ?? 0
		blocking = ratingsDict?["blk"] as? Int ?? 0
		stealing = ratingsDict?["stl"] as? Int ?? 0
		dribbling = ratingsDict?["drb"] as? Int ?? 0
		passing = ratingsDict?["pss"] as? Int ?? 0
		rebounding = ratingsDict?["reb"] as? Int ?? 0
		potential = ratingsDict?["pot"] as? Int ?? 0
		skills = ratingsDict?["skills"] as? [String] ?? [""]
	}
}

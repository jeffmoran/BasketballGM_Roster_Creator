//
//  Injury.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/4/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct Injury {
	var type: String
	var gamesRemaining: Int

	init(_ injuryDict: [String: Any]?) {
		self.type = injuryDict?["tid"] as? String ?? "Healthy"
		self.gamesRemaining = injuryDict?["round"] as? Int ?? 0
	}
}

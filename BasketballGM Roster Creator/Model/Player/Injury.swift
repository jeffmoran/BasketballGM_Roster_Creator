//
//  Injury.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/4/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct Injury: Decodable {
	var type: String
	var gamesRemaining: Int
}

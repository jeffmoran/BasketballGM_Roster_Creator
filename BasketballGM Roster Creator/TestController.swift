//
//  TESTCONtreoler.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 9/13/18.
//  Copyright © 2018 Jeff Moran. All rights reserved.
//

import Cocoa

class TestController: NSArrayController {
	override var arrangedObjects: Any {
		guard let allTeams = API.shared.getAllTeams(includingFakeTeams: true) else { return [""] }

		return allTeams.map { $0.fullTeamName }
	}
}

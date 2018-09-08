//
//  LeagueImporter.swift
//  BasketballGM Roster Creator Tests
//
//  Created by Jeff Moran on 9/7/18.
//  Copyright © 2018 Jeff Moran. All rights reserved.
//

import Foundation

class LeagueImporter {

	class func getLeagueJSONData () -> Data {
//		let filepath = Bundle(for: self).path(forResource: "2018-19.NBA.Roster", ofType: "json") ?? ""
		let filepath = Bundle(for: self).path(forResource: "2018-19.NBA.Roster-fixed", ofType: "json") ?? ""

		let url = URL(fileURLWithPath: filepath)

		do {
			return try Data(contentsOf: url)
		} catch {
			fatalError(error.localizedDescription)
		}
	}
}

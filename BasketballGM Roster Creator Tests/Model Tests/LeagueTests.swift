//
//  LeagueTests.swift
//  BasketballGM Roster Creator Tests
//
//  Created by Jeff Moran on 9/6/18.
//  Copyright © 2018 Jeff Moran. All rights reserved.
//

@testable import BasketballGM_Roster_Creator
import XCTest

class LeagueTests: XCTestCase {

	var league: League!

    override func setUp() {
        super.setUp()

		let leagueData: Data = LeagueImporter.getLeagueJSONData()

		do {
			guard let jsonDict = try JSONSerialization.jsonObject(with: leagueData, options: []) as? [String: Any] else { return }
			league = League(jsonDict)
		} catch {
			return
		}
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testRosterSomething() {
		XCTAssertFalse(league.players.isEmpty)
		XCTAssertFalse(league.teams.isEmpty)
		XCTAssertFalse(league.draftPicks.isEmpty)
	}

}

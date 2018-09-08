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
			league = try JSONDecoder().decode(League.self, from: leagueData)
			league.addFakeTeams()
		} catch {
			print(error)
			fatalError(error.localizedDescription)
		}
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testLeagueIntegrity() {
		XCTAssertFalse(league.players.isEmpty)
		XCTAssertFalse(league.teams.isEmpty)
		XCTAssertFalse(league.draftPicks.isEmpty)
		XCTAssertFalse(league.gameAttributes.isEmpty)
		XCTAssert(league.startingSeason == 2019)
	}

}

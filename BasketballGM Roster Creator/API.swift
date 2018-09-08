//
//  API.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/1/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import AppKit

class API {

	// MARK: - Public Properties

	static var shared: API = API()

	var isLeagueImported: Bool = false

	// MARK: - Private Properties

	private var league: League!

	private var mainController: MainWindowController? {
		return NSApp.mainWindow?.windowController as? MainWindowController
	}

	// MARK: - Roster Import/Export

	func getRosterFrom(_ url: URL, completion: () -> Void) {
		do {
			let leagueData = try Data(contentsOf: url)
			league = try JSONDecoder().decode(League.self, from: leagueData)
			league.addFakeTeams()
			league.update(league.players)

			isLeagueImported = true

			completion()
		} catch {
			print(error)
			fatalError(error.localizedDescription)
		}
	}

	/// Imports the roster JSON file and saves it to the the ~/Documents/BasketballGM_Rosters directory
	///
	/// - Parameter url: The file path as a URL

	func importRoster(_ sourceURL: URL) {
		let filename = sourceURL.lastPathComponent

		let fileManager = FileManager.default

		let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

		let directory = documentsUrl.appendingPathComponent("BasketballGM_Rosters")

		let destinationURL = directory.appendingPathComponent(filename)

		do {
			try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
			try fileManager.copyItem(at: sourceURL, to: destinationURL)
		} catch {
			fatalError(error.localizedDescription)
		}
	}

	func saveRosterToDisk(_ roster: [String: Any]?, withFileName filename: String? = nil) {
		guard let roster = roster else { return }

		if !JSONSerialization.isValidJSONObject(roster) {
			assertionFailure("Not a valid JSON object")
			return
		}

		let fileManager = FileManager.default

		let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

		let directory = documentsUrl.appendingPathComponent("BasketballGM_Rosters")

		try? fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)

		let title = NSApp.mainWindow?.title

		let fileUrl = directory.appendingPathComponent("\(filename ?? title ?? "roster.json")")

		var json: Data!
		var isDirectory: ObjCBool = false

		if !fileManager.fileExists(atPath: fileUrl.absoluteString, isDirectory: &isDirectory) {
			fileManager.createFile(atPath: fileUrl.absoluteString, contents: nil, attributes: nil)
		}

		do {
			json = try JSONSerialization.data(withJSONObject: roster, options: .prettyPrinted)
			try json.write(to: fileUrl)
		} catch {
			assertionFailure(error.localizedDescription)
		}
	}

	// MARK: - Players

	func getAllPlayers() -> [Player]? {
		return league.players
	}

	func getPlayerAt(_ index: Int) -> Player? {
		return getAllPlayers()?[index]
	}

	func removePlayer(at playerID: Int) {
		guard var allPlayers = getAllPlayers() else { return }

		allPlayers.remove(at: playerID)

		league.update(allPlayers)

		mainController?.refreshCollectionViewWith(.players)
	}

	func replacePlayer(at playerID: Int, with player: Player) {
		guard var roster = league else { return }
		guard let allPlayers = getAllPlayers() else { return }

		for index in allPlayers.indices where playerID == index {
			var allPlayers = allPlayers

			allPlayers[index] = player

			self.league.players = allPlayers
		}

		//		guard let jsonDictPlayers = roster.rawDict["players"] as? [[String: Any]] else { return }
		//
		//		for index in jsonDictPlayers.indices where playerID == index {
		//			var allPlayers = jsonDictPlayers
		//
		//			allPlayers[index][""] = player.asDictionary()
		//
		//			roster.rawDict["players"] = allPlayers
		//
		//			self.roster = League(roster.rawDict)
		//		}

		// TODO: Fix this

		//		saveRosterToDisk(roster.asDictionary())

		mainController?.refreshCollectionViewWith(.players)
	}

	// MARK: - Teams

	func getAllTeams(includingFakeTeams: Bool) -> [Team]? {
		return includingFakeTeams ? league.teams : league.teams.filter { $0.tid >= 0 }
	}

	func getTeamAt(_ index: Int) -> Team? {
		return getAllTeams(includingFakeTeams: false)?[index]
	}

	//	func getNumberOfTeams() -> Int {
	//		return getAllTeams()?.count ?? 0
	//	}

	func getTeamWith(_ teamID: Int) -> Team? {
		return getAllTeams(includingFakeTeams: true)?.first { $0.tid == teamID }
	}

	// MARK: - Draft Picks

	func getAllDraftPicks() -> [DraftPick]? {
		return league.draftPicks
	}

	func getNumberOfDraftPicks() -> Int {
		return getAllDraftPicks()?.count ?? 0
	}
}

//
//  API.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/1/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import AppKit

struct API {
	static var shared: API = API()

	var roster: Roster?

	var mainController: MainWindowController? {
		return NSApp.mainWindow?.windowController as? MainWindowController
	}

	// MARK: - Main

	mutating func getRosterFrom(_ url: URL, completion: () -> Void) {
		guard let data = NSData(contentsOf: url) as Data? else { return }

		do {
			guard let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }

			roster = Roster(jsonData)

			completion()
		} catch {
			print(error.localizedDescription)
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

		try? fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)

		let destinationURL = directory.appendingPathComponent(filename)

		do {
			try fileManager.copyItem(at: sourceURL, to: destinationURL)
		} catch {
			print(error.localizedDescription)
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
		} catch {
			assertionFailure(error.localizedDescription)
			return
		}

		do {
			try json.write(to: fileUrl)
		} catch {
			assertionFailure(error.localizedDescription)
			return
		}
	}

	// MARK: - Players

	func getAllPlayers() -> [Player]? {
		return roster?.players
	}

	func getPlayerAt(_ index: Int) -> Player? {
		return getAllPlayers()?[index]
	}

	mutating func removePlayer(at playerID: Int?) {
		guard var allPlayers = getAllPlayers() else { return }
		guard let playerID = playerID else { return }

		allPlayers.remove(at: playerID)

		let allPlayersAdjusted: [Player] = allPlayers.enumerated().map { index, player in
			var player = player
			player.playerID = index

			return player
		}

		roster?.players = allPlayersAdjusted

		mainController?.refreshCollectionViewWith(.players)
	}

	mutating func replacePlayer(at playerID: Int?, with player: Player) {
		guard var roster = roster else { return }
		guard let allPlayers = getAllPlayers() else { return }
		guard let playerID = playerID else { return }

		for index in allPlayers.indices where playerID == index {
			var allPlayers = allPlayers

			allPlayers[index] = player

			self.roster?.players = allPlayers
		}

		guard let jsonDictPlayers = roster.rawDict["players"] as? [[String: Any]] else { return }

		for index in jsonDictPlayers.indices where playerID == index {
			var allPlayers = jsonDictPlayers

			allPlayers[index][""] = player.asDictionary()

			roster.rawDict["players"] = allPlayers

			self.roster = Roster(roster.rawDict)
		}

		// TODO: Fix this

		saveRosterToDisk(roster.asDictionary())

		mainController?.refreshCollectionViewWith(.players)
	}

	// MARK: - Teams

	func getAllTeams(includingFakeTeams: Bool) -> [Team]? {
		return includingFakeTeams ? roster?.teams : roster?.teams.filter { $0.teamID >= 0 }
	}

	func getTeamAt(_ index: Int) -> Team? {
		return getAllTeams(includingFakeTeams: false)?[index]
	}

//	func getNumberOfTeams() -> Int {
//		return getAllTeams()?.count ?? 0
//	}

	func getTeamWith(_ teamID: Int) -> Team? {
		return getAllTeams(includingFakeTeams: true)?.first { $0.teamID == teamID }
	}

	// MARK: - Draft Picks

	func getAllDraftPicks() -> [DraftPick]? {
		return roster?.draftPicks
	}

	func getNumberOfDraftPicks() -> Int {
		return getAllDraftPicks()?.count ?? 0
	}
}

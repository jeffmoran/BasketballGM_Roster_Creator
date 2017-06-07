//
//  API.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/1/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation
import AppKit

struct API {
	static var shared: API = API()

	var roster: Roster?

	var mainController: MainWindowController? {
		return NSApp.mainWindow?.windowController as? MainWindowController
	}

	// MARK: - Main

	mutating func getRosterFrom(_ url: URL, completion: (() -> Void)? = nil) {
		guard let data = NSData(contentsOf: url) as Data? else { return }

		do {
			guard let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }

			roster = Roster(jsonData)
			roster?.rawJSONDict = jsonData
		} catch {
			print(error.localizedDescription)
		}

		completion?()
	}

	/// Imports the roster JSON file and saves it to the the ~/Documents/BasketballGM_Rosters directory
	///
	/// - Parameter url: The file path as a URL

	func importRoster(_ url: URL) {
		guard let data = NSData(contentsOf: url) as Data? else { return }

		guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) else { return }

		let filename = url.lastPathComponent

		saveRosterToDisk(jsonData, withFileName: filename)
	}

	func saveRosterToDisk(_ roster: Any?, withFileName filename: String? = nil) {
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

	func getNumberOfPlayers() -> Int {
		return getAllPlayers()?.count ?? 0
	}

	mutating func replacePlayer(at playerID: Int?, playerDict: [String: Any]) {
		guard let allPlayers = getAllPlayers() else { return }
		guard let playerID = playerID else { return }

		for index in allPlayers.indices where playerID == index {
			var players = roster?.rawJSONDict["players"] as? [[String: Any]]
			players?[index] = playerDict

			roster?.rawJSONDict["players"] = players
		}

		guard let roster = roster?.rawJSONDict else { return }

		self.roster = Roster(roster)

		saveRosterToDisk(roster)

		mainController?.refreshCollectionViewWith(.players)
	}

	// MARK: - Teams

	func getAllTeams() -> [Team]? {
		return roster?.teams
	}

	func getTeamAt(_ index: Int) -> Team? {
		return getAllTeams()?[index]
	}

	func getNumberOfTeams() -> Int {
		return getAllTeams()?.count ?? 0
	}

	func getTeamWith(_ teamID: Int) -> Team? {
		return getAllTeams()?.first(where: { $0.teamID == teamID })
	}

	// MARK: - Draft Picks

	func getAllDraftPicks() -> [DraftPick]? {
		return roster?.draftPicks
	}

	func getNumberOfDraftPicks() -> Int {
		return getAllDraftPicks()?.count ?? 0
	}
}

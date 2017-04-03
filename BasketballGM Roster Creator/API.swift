//
//  API.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/1/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct API {
	static var shared: API = API()

	var roster: Roster?

	// MARK: - Main

	mutating func getRosterFrom(_ url: URL, completion: (() -> Void)? = nil) {
		guard let data = NSData(contentsOf: url) as Data? else { return }

		do {
			guard let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }

			roster = Roster(jsonData)
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
		let fileManager = FileManager.default

		let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

		let directory = documentsUrl.appendingPathComponent("BasketballGM_Rosters")

		try? fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)

		let fileUrl = directory.appendingPathComponent("\(filename)")

		var json: Data!
		var isDirectory: ObjCBool = false

		if !fileManager.fileExists(atPath: fileUrl.absoluteString, isDirectory: &isDirectory) {
			fileManager.createFile(atPath: fileUrl.absoluteString, contents: nil, attributes: nil)
		}

		do {
			json = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
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

	// MARK: - Other
}

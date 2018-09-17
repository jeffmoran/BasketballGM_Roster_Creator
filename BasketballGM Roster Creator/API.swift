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

	func refresh(_ contentMode: ContentMode) {
		mainController?.refreshCollectionViewWith(contentMode)
	}

	func saveLeague(_ fileUrl: URL) {
		guard let league = league else { return }

		var isDirectory: ObjCBool = false

		if !FileManager.default.fileExists(atPath: fileUrl.absoluteString, isDirectory: &isDirectory) {
			FileManager.default.createFile(atPath: fileUrl.absoluteString, contents: nil, attributes: nil)
		}

		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted

		do {
			try encoder.encode(league).write(to: fileUrl)
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

	func remove(_ player: Player) {
		guard let index = league.players.index(of: player) else { return }

		league.players.remove(at: index)

		mainController?.refreshCollectionViewWith(.players)
	}

	// MARK: - Teams

	func getAllTeams(includingFakeTeams: Bool) -> [Team]? {
		guard let league = league else { return nil }
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

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

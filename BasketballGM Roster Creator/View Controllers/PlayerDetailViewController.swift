//
//  PlayerDetailViewController.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/28/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class PlayerDetailViewController: NSViewController {
	var player: Player? {
		didSet {
			playerDetailView.player = player
		}
	}

	private lazy var scrollView: NSScrollView = {
		let scrollView = NSScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.documentView = self.playerDetailView

		return scrollView
	}()

	private lazy var playerDetailView: PlayerDetailView = {
		let view = PlayerDetailView()
		view.translatesAutoresizingMaskIntoConstraints = false

		return view
	}()

	private lazy var deleteButton: NSButton = {
		let button = NSButton(title: "Delete", target: self, action: #selector(deletePlayer))
		button.translatesAutoresizingMaskIntoConstraints = false
		button.bezelStyle = .rounded

		return button
	}()

	private lazy var saveButton: NSButton = {
		let button = NSButton(title: "Save", target: self, action: #selector(savePlayer))
		button.translatesAutoresizingMaskIntoConstraints = false
		button.bezelStyle = .rounded

		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		addSubviews()
		setUpConstraints()
	}

	// MARK: - Private

	private func addSubviews() {
		view.addSubview(scrollView)
		view.addSubview(deleteButton)
		view.addSubview(saveButton)
	}

	private func setUpConstraints() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
			scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
			scrollView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -5),

			playerDetailView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			playerDetailView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
			playerDetailView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),

//			playerDetailView.widthAnchor.constraint(greaterThanOrEqualToConstant: 500),

			deleteButton.rightAnchor.constraint(equalTo: saveButton.leftAnchor, constant: -5),
			deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),

			saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
			saveButton.bottomAnchor.constraint(equalTo: deleteButton.bottomAnchor)
			])
	}

	@objc func deletePlayer() {
		guard let player = player else { return }
		API.shared.removePlayer(at: player.playerID)

		self.player = nil
	}

	@objc func savePlayer() {
		guard let currentPlayer = player else { return }
		guard let adjustedPlayer = playerDetailView.getAdjustedPlayer() else { return }

		API.shared.replacePlayer(at: currentPlayer.playerID, with: adjustedPlayer)
	}
}

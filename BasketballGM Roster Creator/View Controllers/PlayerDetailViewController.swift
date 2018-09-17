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
		scrollView.hasVerticalScroller = true

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

	override func viewDidLoad() {
		super.viewDidLoad()

		addSubviews()
		setUpConstraints()
	}

	// MARK: - Private

	private func addSubviews() {
		view.addSubview(scrollView)
		view.addSubview(deleteButton)
	}

	private func setUpConstraints() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
			scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
			scrollView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -5),

			playerDetailView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			playerDetailView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
			playerDetailView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),

			deleteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
			deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
			])
	}

	@objc func deletePlayer() {
		guard let player = player else { return }

		let alert: NSAlert = NSAlert()
		alert.messageText = "Are you sure?"
		alert.informativeText = "This player will be removed."
		alert.alertStyle = .critical

		alert.addButton(withTitle: "OK")
		alert.addButton(withTitle: "Cancel")

		if alert.runModal() == .alertFirstButtonReturn {
			API.shared.remove(player)

			self.player = nil
		}
	}

}

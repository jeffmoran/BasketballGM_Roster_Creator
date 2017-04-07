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
			guard let player = player else { return }

			playerDetailView.player = player
		}
	}

	lazy private var scrollView: NSScrollView = {
		let scrollView = NSScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.documentView = self.playerDetailView

		return scrollView
	}()

	lazy private var playerDetailView: PlayerDetailView = {
		let view = PlayerDetailView()
		view.translatesAutoresizingMaskIntoConstraints = false

		return view
	}()

	lazy private var saveButton: NSButton = {
		let button = NSButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.title = "Save"
		button.bezelStyle = NSBezelStyle.rounded

		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do view setup here.

		addSubviews()
		setUpConstraints()
	}

	// MARK: - Private

	private func addSubviews() {
		view.addSubview(scrollView)
		view.addSubview(saveButton)
	}

	private func setUpConstraints() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
			scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
			scrollView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -5),

			saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
			saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
			])

		playerDetailView.setUpConstraints()
	}

}

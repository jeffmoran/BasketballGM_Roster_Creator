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

	@IBOutlet weak private var scrollView: NSScrollView! {
		didSet {
			scrollView.documentView = playerDetailView
		}
	}

	lazy private var playerDetailView: PlayerDetailView = {
		let view = PlayerDetailView()
		view.translatesAutoresizingMaskIntoConstraints = false

		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do view setup here.

		addSubviews()
		setUpConstraints()
	}

	// MARK: - Private

	private func addSubviews() {

	}

	private func setUpConstraints() {
		playerDetailView.setUpConstraints()
	}

}

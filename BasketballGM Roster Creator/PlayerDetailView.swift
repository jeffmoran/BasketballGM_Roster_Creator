//
//  PlayerDetailView.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/6/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class PlayerDetailView: NSView {

	// MARK: - Properties

	@IBOutlet private var playerDetailView: NSView!
	@IBOutlet private var playerImageView: NSImageView!

	@objc dynamic var player: Player? {
		didSet {
			guard let player = player else {
				playerImageView.image = nil
				// TODO: Show "no player selected" screen
				return
			}

			playerImageView.downloadedFrom(link: player.imgURL)
		}
	}

	// MARK: - Initializers

	convenience init() {
		self.init(frame: .zero)

		instantiateNib()
	}

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	private func instantiateNib() {
		if let nib = NSNib(nibNamed: NSNib.Name(rawValue: "PlayerDetailView"), bundle: Bundle(for: type(of: self))) {
			nib.instantiate(withOwner: self, topLevelObjects: nil)

			playerDetailView.translatesAutoresizingMaskIntoConstraints = false

			addSubview(playerDetailView)

			NSLayoutConstraint.activate([
				playerDetailView.leadingAnchor.constraint(equalTo: leadingAnchor),
				playerDetailView.trailingAnchor.constraint(equalTo: trailingAnchor),
				playerDetailView.topAnchor.constraint(equalTo: topAnchor),
				playerDetailView.bottomAnchor.constraint(equalTo: bottomAnchor)
				])
		}
	}

	override var isFlipped: Bool {
		return true
	}

}

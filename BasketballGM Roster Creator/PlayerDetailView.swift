//
//  PlayerDetailView.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/6/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation
import Cocoa

class PlayerDetailView: NSView {

	// MARK: - Propoerties

	var player: Player? {
		didSet {
			guard let player = player else { return }

			var teams: [String] = [String]()

			if let allTeams = API.shared.getAllTeams() {
				for team in allTeams {
					teams.append(team.region + " " + team.name)
				}
			}

			playerTeamPopUpButton.removeAllItems()
			playerTeamPopUpButton.addItems(withTitles: teams)

			playerImageView.downloadedFrom(link: player.profileURL)
			playerImageTextField.stringValue = player.profileURL

			playerNameTextField.stringValue = player.name
			playerNameTextField.becomeFirstResponder()

			playerWeightTextField.stringValue = String(player.weight)
			playerHeightTextField.stringValue = String(player.height)

			playerPositionPopUpButton.selectItem(withTitle: player.position.rawValue)

			playerAgeTextField.stringValue = String(player.age)
			playerHometownTextField.stringValue = player.hometown

			if let playerTeam = player.team {
				playerTeamPopUpButton.selectItem(withTitle: playerTeam.region + " " + playerTeam.name)
			} else {
				Swift.print("Free agent/draft prospect?")
			}
		}
	}

	lazy private var playerImageView: NSImageView = {
		let imageView = NSImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false

		return imageView
	}()

	lazy private var playerImageTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	lazy private var playerAttributeLabelStackView: NSStackView = {
		let stackView = NSStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .right
		stackView.orientation = .vertical
		stackView.distribution = .fillProportionally
		return stackView
	}()

	lazy private var playerAttributeTextFieldStackView: NSStackView = {
		let stackView = NSStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .left
		stackView.orientation = .vertical
		stackView.distribution = .fillProportionally

		return stackView
	}()

	lazy private var playerNameLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Name"

		return label
	}()

	lazy private var playerNameTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	lazy private var playerAgeLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Age"

		return label
	}()

	lazy private var playerAgeTextField: PlayerTextField = {
		let textField = PlayerTextField()

		let numberFormatter = OnlyIntegerValueFormatter()
		textField.formatter = numberFormatter

		return textField
	}()

	lazy private var playerHometownLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Hometown"

		return label
	}()

	lazy private var playerHometownTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	lazy private var playerHeightLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Height"

		return label
	}()

	lazy private var playerHeightTextField: PlayerTextField = {
		let textField = PlayerTextField()
		let numberFormatter = OnlyIntegerValueFormatter()
		textField.formatter = numberFormatter

		return textField
	}()

	lazy private var playerWeightLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Weight"

		return label
	}()

	lazy private var playerWeightTextField: PlayerTextField = {
		let textField = PlayerTextField()

		let numberFormatter = OnlyIntegerValueFormatter()
		textField.formatter = numberFormatter

		return textField
	}()

	lazy private var playerPositionLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Position"

		return label
	}()

	lazy private var playerPositionPopUpButton: NSPopUpButton = {
		let popUpButton = NSPopUpButton()
		let positions = Position.allPositions
		popUpButton.addItems(withTitles: positions)

		return popUpButton
	}()

	lazy private var playerTeamLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Team"

		return label
	}()

	lazy private var playerTeamPopUpButton: NSPopUpButton = {
		let popUpButton = NSPopUpButton()
		popUpButton.translatesAutoresizingMaskIntoConstraints = false

		return popUpButton
	}()

	convenience init() {
		self.init(frame: .zero)

		addSubviews()
	}

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override var isFlipped: Bool {
		return true
	}

	private func addSubviews() {
		addSubview(playerImageView)
		addSubview(playerImageTextField)

		addSubview(playerAttributeLabelStackView)
		addSubview(playerAttributeTextFieldStackView)

		playerAttributeLabelStackView.addArrangedSubview(playerNameLabel)
		playerAttributeLabelStackView.addArrangedSubview(playerAgeLabel)
		playerAttributeLabelStackView.addArrangedSubview(playerHometownLabel)
		playerAttributeLabelStackView.addArrangedSubview(playerHeightLabel)
		playerAttributeLabelStackView.addArrangedSubview(playerWeightLabel)
		playerAttributeLabelStackView.addArrangedSubview(playerTeamLabel)
		playerAttributeLabelStackView.addArrangedSubview(playerPositionLabel)

		playerAttributeTextFieldStackView.addArrangedSubview(playerNameTextField)
		playerAttributeTextFieldStackView.addArrangedSubview(playerAgeTextField)
		playerAttributeTextFieldStackView.addArrangedSubview(playerHometownTextField)
		playerAttributeTextFieldStackView.addArrangedSubview(playerHeightTextField)
		playerAttributeTextFieldStackView.addArrangedSubview(playerWeightTextField)
		playerAttributeTextFieldStackView.addArrangedSubview(playerTeamPopUpButton)
		playerAttributeTextFieldStackView.addArrangedSubview(playerPositionPopUpButton)
	}

	func setUpConstraints() {
		guard let superview = superview else { return }

		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			leftAnchor.constraint(equalTo: superview.leftAnchor),
			rightAnchor.constraint(equalTo: superview.rightAnchor),

			widthAnchor.constraint(greaterThanOrEqualToConstant: 400),

			playerImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
			playerImageView.topAnchor.constraint(equalTo: topAnchor),
			playerImageView.heightAnchor.constraint(equalToConstant: 200),
			playerImageView.widthAnchor.constraint(equalTo: playerImageView.heightAnchor),

			playerImageTextField.leftAnchor.constraint(equalTo: playerImageView.rightAnchor, constant: 10),
			playerImageTextField.bottomAnchor.constraint(equalTo: playerImageView.bottomAnchor),
			playerImageTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),

			playerAttributeLabelStackView.topAnchor.constraint(equalTo: playerImageView.bottomAnchor, constant: 8),
			playerAttributeLabelStackView.leftAnchor.constraint(equalTo: playerImageView.leftAnchor),
			playerAttributeLabelStackView.widthAnchor.constraint(equalToConstant: 150),

			playerAttributeTextFieldStackView.topAnchor.constraint(equalTo: playerAttributeLabelStackView.topAnchor),
			playerAttributeTextFieldStackView.leftAnchor.constraint(equalTo: playerAttributeLabelStackView.rightAnchor, constant: 10),
			playerAttributeTextFieldStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
			playerAttributeTextFieldStackView.bottomAnchor.constraint(equalTo: playerAttributeLabelStackView.bottomAnchor),

			bottomAnchor.constraint(equalTo: playerAttributeTextFieldStackView.bottomAnchor, constant: 20)
			])
	}
}

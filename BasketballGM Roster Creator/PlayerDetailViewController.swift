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

			updateTeamPopUpButton()

			playerNameTextField.stringValue = player.name
			playerNameTextField.becomeFirstResponder()

			playerWeightTextField.stringValue = String(player.weight)
			playerHeightTextField.stringValue = String(player.height)

			//            playerPositionPopUpButton.selectItem(withTitle: player.position.rawValue)

			playerAgeTextField.stringValue = String(player.age)
			playerHometownTextField.stringValue = player.hometown

			if let playerTeam = player.team {
				playerTeamPopUpButton.selectItem(withTitle: playerTeam.region + " " + playerTeam.name)
			} else {

			}
		}
	}

	@IBOutlet weak private var scrollView: NSScrollView!

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

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do view setup here.

		addSubviews()
		setUpConstraints()
	}

	// MARK: - Private

	private func addSubviews() {
		scrollView.contentView.addSubview(playerNameLabel)
		scrollView.contentView.addSubview(playerNameTextField)

		scrollView.contentView.addSubview(playerAgeLabel)
		scrollView.contentView.addSubview(playerAgeTextField)

		scrollView.contentView.addSubview(playerHometownLabel)
		scrollView.contentView.addSubview(playerHometownTextField)

		scrollView.contentView.addSubview(playerHeightLabel)
		scrollView.contentView.addSubview(playerHeightTextField)

		scrollView.contentView.addSubview(playerWeightLabel)
		scrollView.contentView.addSubview(playerWeightTextField)

		scrollView.contentView.addSubview(playerTeamLabel)
		scrollView.contentView.addSubview(playerTeamPopUpButton)
	}

	private func setUpConstraints() {
		NSLayoutConstraint.activate([
			view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),

			playerNameLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
			playerNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),

			playerNameTextField.leftAnchor.constraint(equalTo: playerNameLabel.rightAnchor, constant: 10),
			playerNameTextField.bottomAnchor.constraint(equalTo: playerNameLabel.bottomAnchor),
			playerNameTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),

			playerAgeLabel.leftAnchor.constraint(equalTo: playerNameLabel.leftAnchor),
			playerAgeLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 8),
			playerAgeLabel.rightAnchor.constraint(equalTo: playerNameLabel.rightAnchor),

			playerAgeTextField.leftAnchor.constraint(equalTo: playerNameTextField.leftAnchor),
			playerAgeTextField.bottomAnchor.constraint(equalTo: playerAgeLabel.bottomAnchor),
			playerAgeTextField.rightAnchor.constraint(equalTo: playerNameTextField.rightAnchor),

			playerHometownLabel.leftAnchor.constraint(equalTo: playerNameLabel.leftAnchor),
			playerHometownLabel.topAnchor.constraint(equalTo: playerAgeLabel.bottomAnchor, constant: 8),
			playerHometownLabel.rightAnchor.constraint(equalTo: playerNameLabel.rightAnchor),

			playerHometownTextField.leftAnchor.constraint(equalTo: playerNameTextField.leftAnchor),
			playerHometownTextField.bottomAnchor.constraint(equalTo: playerHometownLabel.bottomAnchor),
			playerHometownTextField.rightAnchor.constraint(equalTo: playerNameTextField.rightAnchor),

			playerHeightLabel.leftAnchor.constraint(equalTo: playerNameLabel.leftAnchor),
			playerHeightLabel.topAnchor.constraint(equalTo: playerHometownLabel.bottomAnchor, constant: 8),
			playerHeightLabel.rightAnchor.constraint(equalTo: playerNameLabel.rightAnchor),

			playerHeightTextField.leftAnchor.constraint(equalTo: playerNameTextField.leftAnchor),
			playerHeightTextField.bottomAnchor.constraint(equalTo: playerHeightLabel.bottomAnchor),
			playerHeightTextField.rightAnchor.constraint(equalTo: playerNameTextField.rightAnchor),

			playerWeightLabel.leftAnchor.constraint(equalTo: playerNameLabel.leftAnchor),
			playerWeightLabel.topAnchor.constraint(equalTo: playerHeightLabel.bottomAnchor, constant: 8),
			playerWeightLabel.rightAnchor.constraint(equalTo: playerNameLabel.rightAnchor),

			playerWeightTextField.leftAnchor.constraint(equalTo: playerNameTextField.leftAnchor),
			playerWeightTextField.bottomAnchor.constraint(equalTo: playerWeightLabel.bottomAnchor),
			playerWeightTextField.rightAnchor.constraint(equalTo: playerNameTextField.rightAnchor),

			playerTeamLabel.leftAnchor.constraint(equalTo: playerNameLabel.leftAnchor),
			playerTeamLabel.topAnchor.constraint(equalTo: playerWeightLabel.bottomAnchor, constant: 8),
			playerTeamLabel.rightAnchor.constraint(equalTo: playerNameLabel.rightAnchor),

			playerTeamPopUpButton.leftAnchor.constraint(equalTo: playerNameTextField.leftAnchor),
			playerTeamPopUpButton.bottomAnchor.constraint(equalTo: playerTeamLabel.bottomAnchor),
			playerTeamPopUpButton.rightAnchor.constraint(equalTo: playerNameTextField.rightAnchor)
			])
	}

	private func updateTeamPopUpButton() {
		var teams: [String] = [String]()

		if let allTeams = API.shared.getAllTeams() {
			for team in allTeams {
				teams.append(team.region + " " + team.name)
			}
		}

		playerTeamPopUpButton.removeAllItems()
		playerTeamPopUpButton.addItems(withTitles: teams)
	}

}

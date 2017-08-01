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

	var player: Player? {
		didSet {
			guard let player = player else {
				// TODO: Show "no player selected" screen
				return
			}

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

			playerPositionPopUpButton.selectItem(withTitle: player.position?.rawValue ?? "")

			playerAgeTextField.stringValue = String(player.age)
			playerHometownTextField.stringValue = player.hometown
			playerCollegeTextField.stringValue = player.college

			playerContractAmountTextField.stringValue = player.contract.amountInMillions
			playerContractExpirationTextField.stringValue = player.contract.expirationString

			if let playerTeam = player.team {
				playerTeamPopUpButton.selectItem(withTitle: playerTeam.region + " " + playerTeam.name)
			} else {
				Swift.print("Free agent/draft prospect?")
			}
		}
	}

	private lazy var playerImageView: NSImageView = {
		let imageView = NSImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.imageScaling = .scaleProportionallyUpOrDown

		return imageView
	}()

	private lazy var playerAttributeLabelStackView: NSStackView = {
		let stackView = NSStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .right
		stackView.orientation = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 4.0

		stackView.addArrangedSubview(playerImageLabel)
		stackView.addArrangedSubview(playerNameLabel)
		stackView.addArrangedSubview(playerAgeLabel)
		stackView.addArrangedSubview(playerHometownLabel)
		stackView.addArrangedSubview(playerCollegeLabel)
		stackView.addArrangedSubview(playerHeightLabel)
		stackView.addArrangedSubview(playerWeightLabel)
		stackView.addArrangedSubview(playerPositionLabel)
		stackView.addArrangedSubview(playerTeamLabel)

		return stackView
	}()

	private lazy var playerAttributeTextFieldStackView: NSStackView = {
		let stackView = NSStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .left
		stackView.orientation = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 4.0

		stackView.addArrangedSubview(playerImageTextField)
		stackView.addArrangedSubview(playerNameTextField)
		stackView.addArrangedSubview(playerAgeTextField)
		stackView.addArrangedSubview(playerHometownTextField)
		stackView.addArrangedSubview(playerCollegeTextField)
		stackView.addArrangedSubview(playerHeightTextField)
		stackView.addArrangedSubview(playerWeightTextField)
		stackView.addArrangedSubview(playerPositionPopUpButton)
		stackView.addArrangedSubview(playerTeamPopUpButton)

		return stackView
	}()

	private lazy var playerImageLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Image URL"

		return label
	}()

	private lazy var playerImageTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	private lazy var playerNameLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Name"

		return label
	}()

	private lazy var playerNameTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	private lazy var playerAgeLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Age"

		return label
	}()

	private lazy var playerAgeTextField: PlayerTextField = {
		let textField = PlayerTextField()

		let numberFormatter = OnlyIntegerValueFormatter()
		textField.formatter = numberFormatter

		return textField
	}()

	private lazy var playerHometownLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Hometown"

		return label
	}()

	private lazy var playerHometownTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	private lazy var playerCollegeLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "College"

		return label
	}()

	private lazy var playerCollegeTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	private lazy var playerHeightLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Height"

		return label
	}()

	private lazy var playerHeightTextField: PlayerTextField = {
		let textField = PlayerTextField()
		let numberFormatter = OnlyIntegerValueFormatter()
		textField.formatter = numberFormatter

		return textField
	}()

	private lazy var playerWeightLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Weight"

		return label
	}()

	private lazy var playerWeightTextField: PlayerTextField = {
		let textField = PlayerTextField()

		let numberFormatter = OnlyIntegerValueFormatter()
		textField.formatter = numberFormatter

		return textField
	}()

	private lazy var playerPositionLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Position"

		return label
	}()

	private lazy var playerPositionPopUpButton: NSPopUpButton = {
		let popUpButton = NSPopUpButton()
		let positions = Position.allPositions
		popUpButton.addItems(withTitles: positions)

		return popUpButton
	}()

	private lazy var playerTeamLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Team"

		return label
	}()

	private lazy var playerTeamPopUpButton: NSPopUpButton = {
		let popUpButton = NSPopUpButton()
		popUpButton.translatesAutoresizingMaskIntoConstraints = false

		return popUpButton
	}()

	private lazy var playerContractLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Contract"

		return label
	}()

	private lazy var playerContractAmountTextField: PlayerTextField = {
		let textField = PlayerTextField()
		textField.placeholderString = "Contract Amount"

		let numberFormatter = OnlyIntegerValueFormatter()
		textField.formatter = numberFormatter

		return textField
	}()

	private lazy var playerContractExpirationTextField: PlayerTextField = {
		let textField = PlayerTextField()
		textField.placeholderString = "Contract Expiration"

		let numberFormatter = OnlyIntegerValueFormatter()
		textField.formatter = numberFormatter

		return textField
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

		addSubview(playerContractLabel)
		addSubview(playerContractAmountTextField)
		addSubview(playerContractExpirationTextField)
	}

	func setUpConstraints() {
		guard let superview = superview else { return }

		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			leftAnchor.constraint(equalTo: superview.leftAnchor),
			rightAnchor.constraint(equalTo: superview.rightAnchor),

			widthAnchor.constraint(greaterThanOrEqualToConstant: 400),

			playerImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
			playerImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
			playerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			playerImageView.heightAnchor.constraint(equalToConstant: 200),

			playerAttributeLabelStackView.topAnchor.constraint(equalTo: playerImageView.bottomAnchor, constant: 8),
			playerAttributeLabelStackView.leftAnchor.constraint(equalTo: playerImageView.leftAnchor),
			playerAttributeLabelStackView.widthAnchor.constraint(equalToConstant: 120),

			playerAttributeTextFieldStackView.topAnchor.constraint(equalTo: playerAttributeLabelStackView.topAnchor),
			playerAttributeTextFieldStackView.leftAnchor.constraint(equalTo: playerAttributeLabelStackView.rightAnchor, constant: 5),
			playerAttributeTextFieldStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
			playerAttributeTextFieldStackView.bottomAnchor.constraint(equalTo: playerAttributeLabelStackView.bottomAnchor),

			playerContractLabel.leftAnchor.constraint(equalTo: playerAttributeLabelStackView.leftAnchor),
			playerContractLabel.topAnchor.constraint(equalTo: playerAttributeLabelStackView.bottomAnchor, constant: 30),
			playerContractLabel.rightAnchor.constraint(equalTo: playerAttributeLabelStackView.rightAnchor),

			playerContractAmountTextField.leftAnchor.constraint(equalTo: playerContractLabel.rightAnchor, constant: 10),
			playerContractAmountTextField.topAnchor.constraint(equalTo: playerContractLabel.topAnchor),
			playerContractAmountTextField.widthAnchor.constraint(equalTo: playerContractExpirationTextField.widthAnchor),

			playerContractExpirationTextField.leftAnchor.constraint(equalTo: playerContractAmountTextField.rightAnchor, constant: 10),
			playerContractExpirationTextField.topAnchor.constraint(equalTo: playerContractLabel.topAnchor),
			playerContractExpirationTextField.rightAnchor.constraint(equalTo: playerAttributeTextFieldStackView.rightAnchor),

			bottomAnchor.constraint(equalTo: playerContractExpirationTextField.bottomAnchor, constant: 20)
			])
	}

	func getPlayer() -> Player? {
		var player = self.player

		player?.profileURL = playerImageTextField.stringValue
		player?.name = playerNameTextField.stringValue
		player?.age = Int(playerAgeTextField.stringValue) ?? 0
		player?.hometown = playerHometownTextField.stringValue
		player?.height = Int(playerHeightTextField.stringValue) ?? 0
		player?.weight = Int(playerWeightTextField.stringValue) ?? 0
		player?.teamID = playerTeamPopUpButton.indexOfSelectedItem
		player?.position = Position(rawValue: playerPositionPopUpButton.selectedItem?.title ?? "")
		player?.contract.amountInMillions = playerContractAmountTextField.stringValue
		player?.contract.expirationString = playerContractExpirationTextField.stringValue

		// TODO: Add rest of player properties here

		return player
	}
}

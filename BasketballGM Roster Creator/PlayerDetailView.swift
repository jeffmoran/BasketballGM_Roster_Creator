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

			// Ratings

			potentialRatingView.value = player.ratings.potential

			heightRatingView.value = player.ratings.height
			strengthRatingView.value = player.ratings.strength
			speedRatingView.value = player.ratings.speed
			jumpingRatingView.value = player.ratings.jumping
			enduranceRatingView.value = player.ratings.endurance

			insideRatingView.value = player.ratings.inside
			dunksLayupsRatingView.value = player.ratings.dunking
			freeThrowsRatingView.value = player.ratings.freeThrow
			twoPointersRatingView.value = player.ratings.fieldGoal
			threePointersRatingView.value = player.ratings.threePointer

			blocksRatingView.value = player.ratings.blocking
			stealsRatingView.value = player.ratings.stealing
			dribblingRatingView.value = player.ratings.dribbling
			passingRatingView.value = player.ratings.passing
			reboundingRatingView.value = player.ratings.rebounding
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

	// MARK: - Ratings Subviews

	private lazy var potentialRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.label.stringValue = "Potential"

		return view
	}()

	// MARK: - Player Ratings - Physical

	private lazy var playerRatingsLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.font = NSFont(name: "HelveticaNeue-Bold", size: 30)

		label.stringValue = "Ratings"
		label.alignment = .left

		return label
	}()

	private lazy var heightRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Height"

		return view
	}()

	private lazy var strengthRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Strength"

		return view
	}()

	private lazy var speedRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Speed"

		return view
	}()

	private lazy var jumpingRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Jumping"

		return view
	}()

	private lazy var enduranceRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Endurance"

		return view
	}()

	private lazy var physicalStackView: NSStackView = {
		let stackView = NSStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.orientation = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 4.0

		stackView.setHuggingPriority(.windowSizeStayPut, for: .horizontal)

		stackView.addArrangedSubview(heightRatingView)
		stackView.addArrangedSubview(strengthRatingView)
		stackView.addArrangedSubview(speedRatingView)
		stackView.addArrangedSubview(jumpingRatingView)
		stackView.addArrangedSubview(enduranceRatingView)

		return stackView
	}()

	// MARK: - Player Ratings - Shooting

	private lazy var insideRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Inside"

		return view
	}()

	private lazy var dunksLayupsRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Dunks/Layups"

		return view
	}()

	private lazy var freeThrowsRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Free Throws"

		return view
	}()

	private lazy var twoPointersRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Two Pointers"

		return view
	}()

	private lazy var threePointersRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Three Pointers"

		return view
	}()

	private lazy var shootingStackView: NSStackView = {
		let stackView = NSStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.orientation = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 4.0

		stackView.setHuggingPriority(.windowSizeStayPut, for: .horizontal)

		stackView.addArrangedSubview(insideRatingView)
		stackView.addArrangedSubview(dunksLayupsRatingView)
		stackView.addArrangedSubview(freeThrowsRatingView)
		stackView.addArrangedSubview(twoPointersRatingView)
		stackView.addArrangedSubview(threePointersRatingView)

		return stackView
	}()

	// MARK: - Player Ratings - Skill

	private lazy var blocksRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Blocks"

		return view
	}()

	private lazy var stealsRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Steals"

		return view
	}()

	private lazy var dribblingRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Dribbling"

		return view
	}()

	private lazy var passingRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Passing"

		return view
	}()

	private lazy var reboundingRatingView: LabelTextFieldGroupView = {
		let view = LabelTextFieldGroupView()
		view.label.stringValue = "Rebounding"

		return view
	}()

	private lazy var skillStackView: NSStackView = {
		let stackView = NSStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.orientation = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 4.0

		stackView.setHuggingPriority(.windowSizeStayPut, for: .horizontal)

		stackView.addArrangedSubview(blocksRatingView)
		stackView.addArrangedSubview(stealsRatingView)
		stackView.addArrangedSubview(dribblingRatingView)
		stackView.addArrangedSubview(passingRatingView)
		stackView.addArrangedSubview(reboundingRatingView)

		return stackView
	}()

	// MARK: - Initializers

	convenience init() {
		self.init(frame: .zero)

		addSubviews()
		setUpConstraints()
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

	// MARK: - Private Interface

	private func addSubviews() {
		addSubview(playerImageView)
		addSubview(playerImageTextField)

		addSubview(playerAttributeLabelStackView)
		addSubview(playerAttributeTextFieldStackView)

		addSubview(playerContractLabel)
		addSubview(playerContractAmountTextField)
		addSubview(playerContractExpirationTextField)

		addSubview(playerRatingsLabel)
		addSubview(potentialRatingView)

		addSubview(physicalStackView)
		addSubview(shootingStackView)
		addSubview(skillStackView)
	}

	private func setUpConstraints() {
		NSLayoutConstraint.activate([
			playerImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
			playerImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
			playerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			playerImageView.heightAnchor.constraint(equalToConstant: 200),

			playerAttributeLabelStackView.topAnchor.constraint(equalTo: playerImageView.bottomAnchor, constant: 8),
			playerAttributeLabelStackView.leftAnchor.constraint(equalTo: playerImageView.leftAnchor),
			playerAttributeLabelStackView.widthAnchor.constraint(equalToConstant: 120),

			playerAttributeTextFieldStackView.topAnchor.constraint(equalTo: playerAttributeLabelStackView.topAnchor),
			playerAttributeTextFieldStackView.leftAnchor.constraint(equalTo: playerAttributeLabelStackView.rightAnchor, constant: 5),
			playerAttributeTextFieldStackView.rightAnchor.constraint(equalTo: playerImageView.rightAnchor),
			playerAttributeTextFieldStackView.bottomAnchor.constraint(equalTo: playerAttributeLabelStackView.bottomAnchor),

			playerContractLabel.leftAnchor.constraint(equalTo: playerAttributeLabelStackView.leftAnchor),
			playerContractLabel.topAnchor.constraint(equalTo: playerAttributeLabelStackView.bottomAnchor, constant: 8),
			playerContractLabel.rightAnchor.constraint(equalTo: playerAttributeLabelStackView.rightAnchor),

			playerContractAmountTextField.leftAnchor.constraint(equalTo: playerAttributeTextFieldStackView.leftAnchor),
			playerContractAmountTextField.topAnchor.constraint(equalTo: playerContractLabel.topAnchor),
			playerContractAmountTextField.widthAnchor.constraint(equalTo: playerContractExpirationTextField.widthAnchor),

			playerContractExpirationTextField.leftAnchor.constraint(equalTo: playerContractAmountTextField.rightAnchor, constant: 10),
			playerContractExpirationTextField.topAnchor.constraint(equalTo: playerContractLabel.topAnchor),
			playerContractExpirationTextField.rightAnchor.constraint(equalTo: playerAttributeTextFieldStackView.rightAnchor),

			playerRatingsLabel.leftAnchor.constraint(equalTo: playerImageView.leftAnchor),
			playerRatingsLabel.rightAnchor.constraint(equalTo: playerImageView.rightAnchor),
			playerRatingsLabel.topAnchor.constraint(equalTo: playerContractLabel.bottomAnchor, constant: 20),

			potentialRatingView.leftAnchor.constraint(equalTo: playerRatingsLabel.leftAnchor),
			potentialRatingView.rightAnchor.constraint(equalTo: playerAttributeLabelStackView.rightAnchor),
			potentialRatingView.topAnchor.constraint(equalTo: playerRatingsLabel.bottomAnchor, constant: 10),

			physicalStackView.leftAnchor.constraint(equalTo: playerAttributeLabelStackView.leftAnchor),
			physicalStackView.topAnchor.constraint(equalTo: potentialRatingView.bottomAnchor, constant: 10),

			shootingStackView.leftAnchor.constraint(equalTo: physicalStackView.rightAnchor, constant: 30),
			shootingStackView.topAnchor.constraint(equalTo: physicalStackView.topAnchor),
			shootingStackView.widthAnchor.constraint(equalTo: physicalStackView.widthAnchor),

			skillStackView.leftAnchor.constraint(equalTo: shootingStackView.rightAnchor, constant: 30),
			skillStackView.topAnchor.constraint(equalTo: physicalStackView.topAnchor),
			skillStackView.rightAnchor.constraint(lessThanOrEqualTo: playerImageView.rightAnchor),
			skillStackView.widthAnchor.constraint(equalTo: shootingStackView.widthAnchor),

			bottomAnchor.constraint(equalTo: skillStackView.bottomAnchor, constant: 20)
			])
	}

	// MARK: - Public Interface

	func getAdjustedPlayer() -> Player? {
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

		player?.ratings.potential = potentialRatingView.value
		player?.ratings.height = heightRatingView.value
		player?.ratings.strength = strengthRatingView.value
		player?.ratings.speed = speedRatingView.value
		player?.ratings.jumping = jumpingRatingView.value
		player?.ratings.endurance = enduranceRatingView.value
		player?.ratings.inside = insideRatingView.value
		player?.ratings.dunking = dunksLayupsRatingView.value
		player?.ratings.freeThrow = freeThrowsRatingView.value
		player?.ratings.fieldGoal = twoPointersRatingView.value
		player?.ratings.threePointer = threePointersRatingView.value
		player?.ratings.blocking = blocksRatingView.value
		player?.ratings.stealing = stealsRatingView.value
		player?.ratings.dribbling = dribblingRatingView.value
		player?.ratings.passing = passingRatingView.value
		player?.ratings.rebounding = reboundingRatingView.value

		// TODO: Add rest of player properties here

		return player
	}
}

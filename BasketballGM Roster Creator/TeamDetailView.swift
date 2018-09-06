//
//  TeamDetailView.swift
//  BasketballGM Roster Creator
//
//  Created by Jeffrey Moran on 8/3/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class TeamDetailView: NSView {
	var team: Team? {
		didSet {
			guard let team = team else {
				// TODO: Show "no team selected" screen
				return
			}

			teamImageView.downloadedFrom(link: team.imageURL)
			teamImageTextField.stringValue = team.imageURL
			teamRegionTextField.stringValue = team.region
			teamNameTextField.stringValue = team.name
			teamAbbreviationTextField.stringValue = team.abbreviation
			teamPopulationTextField.stringValue = team.populationString
			teamStrategyTextField.stringValue = team.strategy
			teamIDTextField.stringValue = String(team.teamID)
			teamConferenceIDPopUpButton.selectItem(at: team.conferenceID)
			teamDivisionPopUpButton.selectItem(at: team.divisionID)
		}
	}

	private lazy var teamImageView: NSImageView = {
		let imageView = NSImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.imageScaling = .scaleProportionallyUpOrDown

		return imageView
	}()

	private lazy var teamAttributeLabelStackView: NSStackView = {
		let stackView = NSStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .right
		stackView.orientation = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 4.0

		stackView.addArrangedSubview(teamImageLabel)
		stackView.addArrangedSubview(teamRegionLabel)
		stackView.addArrangedSubview(teamNameLabel)
		stackView.addArrangedSubview(teamAbbreviationLabel)
		stackView.addArrangedSubview(teamPopulationLabel)
		stackView.addArrangedSubview(teamStrategyLabel)
		stackView.addArrangedSubview(teamIDLabel)
		stackView.addArrangedSubview(teamConferenceIDLabel)
		stackView.addArrangedSubview(teamDivisionLabel)

		return stackView
	}()

	private lazy var teamAttributeTextFieldStackView: NSStackView = {
		let stackView = NSStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .left
		stackView.orientation = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 4.0

		stackView.addArrangedSubview(teamImageTextField)
		stackView.addArrangedSubview(teamRegionTextField)
		stackView.addArrangedSubview(teamNameTextField)
		stackView.addArrangedSubview(teamAbbreviationTextField)
		stackView.addArrangedSubview(teamPopulationTextField)
		stackView.addArrangedSubview(teamStrategyTextField)
		stackView.addArrangedSubview(teamIDTextField)
		stackView.addArrangedSubview(teamConferenceIDPopUpButton)
		stackView.addArrangedSubview(teamDivisionPopUpButton)

		return stackView
	}()

	private lazy var teamImageLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Image URL"

		return label
	}()

	private lazy var teamImageTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	private lazy var teamRegionLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Region"

		return label
	}()

	private lazy var teamRegionTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	private lazy var teamNameLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Name"

		return label
	}()

	private lazy var teamNameTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	private lazy var teamAbbreviationLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Abbreviation"

		return label
	}()

	private lazy var teamAbbreviationTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	private lazy var teamPopulationLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Population"

		return label
	}()

	private lazy var teamPopulationTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	private lazy var teamStrategyLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Strategy"

		return label
	}()

	private lazy var teamStrategyTextField: PlayerTextField = {
		let textField = PlayerTextField()

		return textField
	}()

	private lazy var teamIDLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Team ID"

		return label
	}()

	private lazy var teamIDTextField: PlayerTextField = {
		let textField = PlayerTextField()

		let numberFormatter = OnlyIntegerValueFormatter()
		textField.formatter = numberFormatter

		return textField
	}()

	private lazy var teamConferenceIDLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Conference"

		return label
	}()

	private lazy var teamConferenceIDPopUpButton: NSPopUpButton = {
		let popUpButton = NSPopUpButton()
		let conferences = Team.allConferences
		popUpButton.addItems(withTitles: conferences)

		return popUpButton
	}()

	private lazy var teamDivisionLabel: PlayerLabel = {
		let label = PlayerLabel()
		label.stringValue = "Division"

		return label
	}()

	private lazy var teamDivisionPopUpButton: NSPopUpButton = {
		let popUpButton = NSPopUpButton()
		let divisions = Team.allDivisions
		popUpButton.addItems(withTitles: divisions)

		return popUpButton
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
		addSubview(teamImageView)

		addSubview(teamAttributeLabelStackView)
		addSubview(teamAttributeTextFieldStackView)
	}

	private func setUpConstraints() {
		NSLayoutConstraint.activate([
			teamImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
			teamImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
			teamImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			teamImageView.heightAnchor.constraint(equalToConstant: 200),

			teamAttributeLabelStackView.topAnchor.constraint(equalTo: teamImageView.bottomAnchor, constant: 8),
			teamAttributeLabelStackView.leftAnchor.constraint(equalTo: teamImageView.leftAnchor),
			teamAttributeLabelStackView.widthAnchor.constraint(equalToConstant: 130),

			teamAttributeTextFieldStackView.topAnchor.constraint(equalTo: teamAttributeLabelStackView.topAnchor),
			teamAttributeTextFieldStackView.leftAnchor.constraint(equalTo: teamAttributeLabelStackView.rightAnchor, constant: 5),
			teamAttributeTextFieldStackView.rightAnchor.constraint(equalTo: teamImageView.rightAnchor),
			teamAttributeTextFieldStackView.bottomAnchor.constraint(equalTo: teamAttributeLabelStackView.bottomAnchor),

			bottomAnchor.constraint(equalTo: teamAttributeTextFieldStackView.bottomAnchor, constant: 20)
			])
	}
}

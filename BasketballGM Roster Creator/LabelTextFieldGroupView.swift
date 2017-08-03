//
//  LabelTextFieldGroupView.swift
//  BasketballGM Roster Creator
//
//  Created by Jeffrey Moran on 8/2/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class LabelTextFieldGroupView: NSView {
	enum Configuration {
		case number(placeholder: String), string(placeholder: String)
	}

	var configuration: Configuration?

	var intValue: Int {
		get {
			return Int(textField.stringValue) ?? 0
		}
		set {
			textField.stringValue = String(newValue)
		}
	}

	var stringValue: String {
		get {
			return textField.stringValue
		}
		set {
			textField.stringValue = newValue
		}
	}

	// MARK: - Subviews

	lazy var label: PlayerLabel = {
		let label = PlayerLabel()
		label.alignment = .left

		return label
	}()

	private lazy var textField: PlayerTextField = {
		let textField = PlayerTextField()

		switch self.configuration {
		case .number(let placeholder)?:
			textField.placeholderString = placeholder
			let numberFormatter = OnlyIntegerValueFormatter()
			textField.formatter = numberFormatter
		case .string(let placeholder)?:
			textField.placeholderString = placeholder
		case .none:
			break
		}

		return textField
	}()

	// MARK: - Initializers

	convenience init(configuration: Configuration) {
		self.init(frame: .zero)

		self.configuration = configuration

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

	private func addSubviews() {
		addSubview(label)
		addSubview(textField)
	}

	private func setUpConstraints() {
		NSLayoutConstraint.activate([
			label.leftAnchor.constraint(equalTo: leftAnchor),
			label.rightAnchor.constraint(equalTo: rightAnchor),
			label.topAnchor.constraint(equalTo: topAnchor),

			textField.leftAnchor.constraint(equalTo: label.leftAnchor),
			textField.rightAnchor.constraint(equalTo: label.rightAnchor),
			textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
			textField.bottomAnchor.constraint(equalTo: bottomAnchor)
			])
	}
}

//
//  LabelTextFieldGroupView.swift
//  BasketballGM Roster Creator
//
//  Created by Jeffrey Moran on 8/2/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class LabelTextFieldGroupView: NSView {
	var value: Int {
		get {
			return Int(textField.stringValue) ?? 0
		}
		set {
			textField.stringValue = String(newValue)
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
		textField.placeholderString = "0 - 100"

		let numberFormatter = OnlyIntegerValueFormatter()
		textField.formatter = numberFormatter

		return textField
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

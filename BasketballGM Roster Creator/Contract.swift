//
//  Contract.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/8/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct Contract: Decodable {
	private var amount: Double?
	private var exp: Int?

	var amountInMillions: String {
		get {
			let millions = amount! * 1000
			let numberFormatter = NumberFormatter()
			numberFormatter.numberStyle = .decimal

			return numberFormatter.string(from: NSNumber(value: millions)) ?? ""
		}
		set {
			amount = (Double(newValue) ?? 0) / 1000
		}

	}

	var expirationString: String {
		get {
			return String(exp!)
		}
		set {
			exp = Int(newValue) ?? 0
		}
	}
}

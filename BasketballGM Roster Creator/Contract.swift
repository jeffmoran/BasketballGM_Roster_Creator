//
//  Contract.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/8/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

struct Contract {
	private var amount: Int
	private var expiration: Int

	init(_ contractDict: [String: Any]?) {
		self.amount = contractDict?["amount"] as? Int ?? 0
		self.expiration = contractDict?["exp"] as? Int ?? 0
	}

	var amountInMillions: String {
		get {
			let millions = amount * 1000
			let numberFormatter = NumberFormatter()
			numberFormatter.numberStyle = .decimal

			return numberFormatter.string(from: NSNumber(value: millions)) ?? ""
		}
		set {
			amount = (Int(newValue) ?? 0) / 1000
		}

	}

	var expirationString: String {
		get {
			return String(expiration)
		}
		set {
			expiration = Int(newValue) ?? 0
		}
	}
}

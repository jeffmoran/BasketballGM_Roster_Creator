//
//  BaseCollectionViewItem.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 8/1/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class BaseCollectionViewItem: NSCollectionViewItem {

	override func viewDidLoad() {
		super.viewDidLoad()

		view.wantsLayer = true
		view.layer?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		view.layer?.borderColor = #colorLiteral(red: 0.06659137458, green: 0.4527410865, blue: 0.698549211, alpha: 1)
		view.layer?.borderWidth = 3.0
		view.layer?.cornerRadius = 15.0
	}

	override var isSelected: Bool {
		didSet {
			view.layer?.borderColor = isSelected ? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) : #colorLiteral(red: 0.06659137458, green: 0.4527410865, blue: 0.698549211, alpha: 1)
		}
	}
    
}

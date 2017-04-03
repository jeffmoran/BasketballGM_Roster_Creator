//
//  PlayerTextField.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/2/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation
import Cocoa

class PlayerTextField: NSTextField {
    convenience init() {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        isEditable = true
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PlayerLabel: NSTextField {
    convenience init() {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        isEditable = false
        isBordered = false
        font = NSFont.systemFont(ofSize: 20)
//        backgroundColor = nil
        alignment = .right
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
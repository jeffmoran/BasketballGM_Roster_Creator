//
//  NumberFormatter.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/2/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation

class OnlyIntegerValueFormatter: NumberFormatter {
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {

        if partialString.isEmpty {
            return true
        }

        return Int(partialString) != nil
    }
}

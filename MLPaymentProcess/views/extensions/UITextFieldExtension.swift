//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    func allowAppendStringForPrice(_ stringToAppend:String, maxLength:Int, maxDecimals:Int = 2) -> Bool {
        let str = self.text!
        let newText = str + stringToAppend
        let allowedCharacters = CharacterSet.decimalDigits
        let comma = ","
        let dot = "."
        let newSpecialCharacter = stringToAppend == dot || stringToAppend == comma

        let stringParts = str.components(separatedBy: dot).count > 1 ? str.components(separatedBy: dot) : str.components(separatedBy: comma)
        let separatorExists = stringParts.count > 1

        guard newText != comma && newText != dot else {
            return false
        }

        guard !(newSpecialCharacter && separatorExists) else {
            return false
        }

        var successful = allowedCharacters.isSuperset(of: CharacterSet(charactersIn: stringToAppend))

        guard successful || newSpecialCharacter else {
            return false
        }

        var maximumLength = maxLength
        if separatorExists || newSpecialCharacter {
            successful = true
            let firstPart = stringParts[0]
            maximumLength = firstPart.lengthOfBytes(using: .utf8) + 1 + maxDecimals
        }

        if successful {
            let length = newText.lengthOfBytes(using: .utf8)
            successful = length <= maximumLength
        }

        return successful
    }

}
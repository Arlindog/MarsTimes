//
//  String+Extensions.swift
//  MarsTimes
//
//  Created by Arlindo on 8/31/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

extension String {
    var excludingPunctuations: String {
        return trimmingCharacters(in: .punctuationCharacters)
    }

    var proceedingPunctuations: [Character]? {
        var punctuations: [Character] = []
        for character in self {
            if character.isPunctuation {
                punctuations.append(character)
            } else {
                break
            }
        }

        return !punctuations.isEmpty ? punctuations : nil
    }

    var trailingPunctuations: [Character]? {
        var punctuations: [Character] = []
        let reversed = self.reversed()
        for (index, character) in reversed.enumerated() {
            if character.isPunctuation {
                // Check if the `.` is part of an abbreviation, if it is skip adding the punctuaiton and break from the loop
                if character == ".",
                    // If last character in the string will be the period
                    index > 0,
                    // If the next character is not the last character
                    index + 1 < reversed.count,
                    // and the next chatacyer is a letter
                    reversed[reversed.index(reversed.startIndex, offsetBy: index + 1)].isLetter {
                        // the `.` is singaling an abbreviation
                        break
                    }
                punctuations.append(character)
            } else {
                break
            }

        }

        return !punctuations.isEmpty ? punctuations.reversed() : nil
    }
}

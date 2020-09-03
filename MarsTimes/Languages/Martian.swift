//
//  Martian.swift
//  MarsTimes
//
//  Created by Arlindo on 8/31/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

struct Martian: LanguageType {
    static let rules: [LanguageRule] = [.alphaOnly, .length(4)]

    static func translate(_ string: String) -> String {
        for rule in rules {
            switch rule {
            case .length(let maxLength):
                guard string.trimmingCharacters(in: .punctuationCharacters).count >= maxLength else {
                    return string
                }
            case .alphaOnly:
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                let isNumber = formatter.number(from: string) != nil

                guard !isNumber else { return string }
            }
        }

        var transformedString: String = "boinga"

        // Maintain Capitalization
        if let firstLetter = string.first(where: { $0.isLetter }),
            firstLetter.isUppercase {
            transformedString = transformedString.capitalized
        }

        // Maintain Punctuations
        if let proceedingPunctuations = string.proceedingPunctuations {
            transformedString = "\(String(proceedingPunctuations))\(transformedString)"
        }

        if let trailingPunctuations = string.trailingPunctuations {
            transformedString = "\(transformedString)\(String(trailingPunctuations))"
        }

        return transformedString
    }
}

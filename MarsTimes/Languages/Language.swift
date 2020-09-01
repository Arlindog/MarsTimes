//
//  Language.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

enum LanguageRule {
    case length(Int)
    case alphaOnly
}

protocol LanguageType {
    static var rules: [LanguageRule] { get }
    static func translate(_ string: String) -> String
}

enum Language: String {
    static let supportedLanguages: [Language] = [
        .english,
        .martian
    ]

    case english = "English"
    case martian = "Martian"
}

extension Language {
    func translate(_ string: String) -> String {
        switch self {
        case .english:
            return string
        case .martian:
            return Martian.translate(string)
        }
    }
}

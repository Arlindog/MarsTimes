//
//  Translator.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

typealias LanguageCache = [String: String]

class Translator {
    static let shared = Translator()

    var languageCaches: [Language: LanguageCache] = [:]

    func translate(string: String, to language: Language) -> String {
        let lineComponents = string.components(separatedBy: .newlines)
        return lineComponents
            .map { line in
                let wordComponents = line.components(separatedBy: .whitespaces)
                return wordComponents
                    .map { (singleString: String) in
                        if let translatedString = languageCaches[language]?[singleString] {
                            return translatedString
                        } else {
                            let translatedString = language.translate(singleString)
                            updateCache(originalString: singleString, translatedString: translatedString, translatedLanguage: language)
                            return translatedString
                        }
                    }
                    .joined(separator: " ")
            }
            .joined(separator: "\n")
    }

    private func updateCache(originalString: String, translatedString: String, translatedLanguage: Language) {
        var languageCache = languageCaches[translatedLanguage] ?? [:]
        languageCache.updateValue(translatedString, forKey: originalString)
        languageCaches.updateValue(languageCache, forKey: translatedLanguage)
    }
}

//
//  LanguageManager.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let currentLanguageChanged = Notification.Name("currentLanguageChanged")
}

class LanguageManager {
    static let shared = LanguageManager()
    let defaultLanguage: Language = .english

    private(set) var currentLanguage: Language

    private init() {
        currentLanguage = UserDefaults.standard.currentLanguage ?? .english
    }

    func updateCurrentLanage(to language: Language) {
        guard currentLanguage != language else { return }
        currentLanguage = language
        UserDefaults.standard.currentLanguage = language
        NotificationCenter.default.post(name: .currentLanguageChanged, object: nil)
    }
}

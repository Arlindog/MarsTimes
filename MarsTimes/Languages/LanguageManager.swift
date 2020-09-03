//
//  LanguageManager.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxSwift
import RxCocoa

class LanguageManager {
    static let shared = LanguageManager()
    let defaultLanguage: Language = .english

    private let currentLanguageRelay: BehaviorRelay<Language>

    var currentLanguageDriver: Driver<Language> {
        return currentLanguageRelay.asDriver()
    }

    private init() {
        currentLanguageRelay = .init(value: UserDefaults.standard.currentLanguage ?? .english)
    }

    func updateCurrentLanage(to language: Language) {
        guard currentLanguageRelay.value != language else { return }
        currentLanguageRelay.accept(language)
        UserDefaults.standard.currentLanguage = language
    }

    func localize(_ string: String) -> String {
        return Translator.shared.translate(string: string, to: currentLanguageRelay.value)
    }

    func localize(_ string: String) -> Driver<String> {
        return currentLanguageDriver
            .map {
                Translator.shared.translate(string: string, to: $0)
            }
    }
}

extension String {
    func localized() -> String {
        return LanguageManager.shared.localize(self)
    }

    func localized() -> Driver<String> {
        return LanguageManager.shared.localize(self)
    }
}

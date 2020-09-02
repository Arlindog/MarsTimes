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

    var currentLanguageObservable: Observable<Language> {
        return currentLanguageRelay.asObservable()
    }

    private init() {
        currentLanguageRelay = .init(value: UserDefaults.standard.currentLanguage ?? .english)
    }

    func updateCurrentLanage(to language: Language) {
        guard currentLanguageRelay.value != language else { return }
        currentLanguageRelay.accept(language)
        UserDefaults.standard.currentLanguage = language
    }
}

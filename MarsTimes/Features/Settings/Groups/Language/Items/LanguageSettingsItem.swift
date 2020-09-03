//
//  LanguageSettingsItem.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxCocoa

class LanguageSettingsItem: ActionableSettingItem {
    let cellIdentifier: String = LanguageSettingCell.identifier

    let language: Language
    private let languageManager: LanguageManager

    var title: String {
        return language.rawValue
    }

    var isSelectedDriver: Driver<Bool> {
        return languageManager.currentLanguageDriver
            .map { [weak self] in
                guard let self = self else { return false }
                return $0 == self.language
            }
    }

    init(language: Language,
         languageManager: LanguageManager) {
        self.language = language
        self.languageManager = languageManager
    }

    func didSelectItem() {
        languageManager.updateCurrentLanage(to: language)
    }
}

//
//  LanguageSettingsItem.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

class LanguageSettingsItem: ActionableSettingItem {
    let cellIdentifier: String = LanguageSettingCell.identifier

    let language: Language
    private let languageManager: LanguageManager

    var updateSelectedState: ((Bool) -> Void)? = nil

    var title: String {
        return language.rawValue
    }

    var isSelected: Bool {
        return languageManager.currentLanguage == language
    }

    init(language: Language,
         languageManager: LanguageManager) {
        self.language = language
        self.languageManager = languageManager
        setup()
    }

    private func setup() {
        NotificationCenter.default.addObserver(
            forName: .currentLanguageChanged,
            object: nil,
            queue: .main) { [weak self] _ in
                self?.updateSelectedState?(self?.isSelected ?? false)
        }
    }

    func didSelectItem() {
        languageManager.updateCurrentLanage(to: language)
    }
}

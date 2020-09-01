//
//  LanguageGroup.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

struct LanguageGroup: SettingGroup {
    let headerIdentifier: String = LanguageSettingsHeaderView.identifier
    let items: [SettingItem]

    init(languageManager: LanguageManager) {
        items = Language.supportedLanguages
            .map { language -> SettingItem in
                return LanguageSettingsItem(language: language, languageManager: languageManager)
            }
    }
}

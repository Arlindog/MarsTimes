//
//  SettingsViewModel.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

class SettingsViewModel {
    private let groups: [SettingGroup]

    var settingItemCount: Int {
        return groups.reduce(0) { (result, group) -> Int in
            return result + group.items.count
        }
    }

    init(languageManager: LanguageManager = .shared) {
        groups = [LanguageGroup(languageManager: languageManager)]
    }

    func getSettingGroup(for indexPath: IndexPath) -> SettingGroup? {
        guard indexPath.section < groups.count else { return nil }
        return groups[indexPath.section]
    }

    func getSettingItem(for indexPath: IndexPath) -> SettingItem? {
        guard
            let group = getSettingGroup(for: indexPath),
            indexPath.row < group.items.count
            else { return nil }
        return group.items[indexPath.row]
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard let item = getSettingItem(for: indexPath) as? ActionableSettingItem else { return }
        item.didSelectItem()
    }
}

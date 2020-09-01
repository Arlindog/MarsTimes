//
//  LanguageSettingCell.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import UIKit

class LanguageSettingCell: UITableViewCell, SettingCell {

    @IBOutlet var selectionIndicatorView: UIView!
    @IBOutlet var titleLabel: UILabel!

    weak var languageItem: LanguageSettingsItem?

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        titleLabel.font = .preferredFont(forTextStyle: .body)
    }

    func configure(with settingItem: SettingItem) {
        guard let languageItem = settingItem as? LanguageSettingsItem else { return }
        self.languageItem = languageItem
        titleLabel.text = languageItem.title
        updateSelectionColor(isSelected: languageItem.isSelected)

        languageItem.updateSelectedState = { [weak self] isSelected in
            self?.updateSelectionColor(isSelected: isSelected)
        }
    }

    func updateSelectionColor(isSelected: Bool) {
        selectionIndicatorView.backgroundColor = isSelected ? .lightGray : .clear
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            selectionIndicatorView.backgroundColor = .lightGray
        } else {
            updateSelectionColor(isSelected: languageItem?.isSelected ?? false)
        }
    }
}

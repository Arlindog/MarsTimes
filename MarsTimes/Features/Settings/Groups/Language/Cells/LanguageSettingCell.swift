//
//  LanguageSettingCell.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxSwift

class LanguageSettingCell: UITableViewCell, SettingCell {

    @IBOutlet var selectionIndicatorView: UIView!
    @IBOutlet var titleLabel: UILabel!

    private var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    private func setup() {
        titleLabel.font = .preferredFont(forTextStyle: .body)
    }

    func configure(with settingItem: SettingItem) {
        guard let languageItem = settingItem as? LanguageSettingsItem else { return }
        titleLabel.text = languageItem.title

        languageItem.isSelectedDriver
            .drive(onNext: { [weak self] in
                self?.updateSelectionColor(isSelected: $0)
            })
            .disposed(by: disposeBag)
    }

    func updateSelectionColor(isSelected: Bool) {
        selectionIndicatorView.backgroundColor = isSelected ? .lightGray : .clear
    }
}

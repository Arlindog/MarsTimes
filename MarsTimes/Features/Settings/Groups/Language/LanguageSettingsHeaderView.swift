//
//  LanguageSettingsHeaderView.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxSwift

class LanguageSettingsHeaderView: UITableViewHeaderFooterView {

    private let disposeBag = DisposeBag()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        contentView.addSubview(titleLabel)

        [titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
         titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
         titleLabel.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor),
         titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ].forEach { $0.isActive = true }

        "Languages".localized()
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

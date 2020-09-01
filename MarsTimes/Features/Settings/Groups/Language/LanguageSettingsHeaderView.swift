//
//  LanguageSettingsHeaderView.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import UIKit

class LanguageSettingsHeaderView: UITableViewHeaderFooterView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .black
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = "Languages"
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
        addSubview(titleLabel)

        [titleLabel.topAnchor.constraint(equalTo: topAnchor),
         titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
         titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
         titleLabel.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor)
        ].forEach { $0.isActive = true }
    }
}

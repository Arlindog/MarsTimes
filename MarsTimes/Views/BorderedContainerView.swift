//
//  BorderedContainerView.swift
//  MarsTimes
//
//  Created by Arlindo on 9/4/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import UIKit

class BorderedContainerView: UIView {
    struct Constants {
        static let defaultBorderWidth: CGFloat = 3
        static let defaultBorderColor: CGColor = UIColor.lightGray.cgColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.borderWidth = Constants.defaultBorderWidth
        layer.borderColor = Constants.defaultBorderColor
    }
}

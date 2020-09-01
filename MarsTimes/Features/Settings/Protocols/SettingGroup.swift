//
//  SettingGroup.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

protocol SettingGroup {
    var headerIdentifier: String { get }
    var items: [SettingItem] { get }
}

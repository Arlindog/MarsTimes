//
//  UserDefaults+Extensions.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

extension UserDefaults {
    var currentLanguage: Language? {
        get {
            let rawLanguage = UserDefaults.standard.string(forKey: "currentLanguage") ?? ""
            return Language(rawValue: rawLanguage)
        } set {
            UserDefaults.standard.set(newValue?.rawValue, forKey: "currentLanguage")
        }
    }
}

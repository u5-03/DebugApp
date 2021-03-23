//
//  UserDefaults.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import Foundation

extension UserDefaults {
    var mockType: MockType? {
        get {
            let key = (UserDefaults.standard.value(forKey: MockType.userDefaultKey) as? String) ?? ""
            return MockType(rawValue: key)
        }
        set {
            setValue(MockType.userDefaultKey, forKey: newValue?.rawValue ?? "")
        }
    }
}

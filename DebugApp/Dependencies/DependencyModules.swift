//
//  DependencyModules.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import Foundation

final class DependencyModules {
    static func refreshModule() {
        Dependencies {
            Module { () -> MockProtocol in
                #if DEBUG
                if let mockType = UserDefaults.standard.mockType {
                    return MockService(mockType: mockType)
                } else {
                    return APIService()
                }
                #else
                return APIService()
                #endif
            }
        }
        .build()
    }

    static func resetModule() {
        Dependencies.root = Dependencies({ () -> [Module] in
            return []
        })
    }
}

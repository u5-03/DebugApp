//
//  UIApplication.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/25.
//

import UIKit

public extension UIApplication {

    var isInUnitTests: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}

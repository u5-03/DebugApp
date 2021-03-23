//
//  View.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import SwiftUI

extension View {
    func presentDebugMenu(shouldShow: Binding<Bool>) -> some View {
        ModifiedContent(content: self, modifier: DebugMenuModifier(shouldShow: shouldShow))
    }
}

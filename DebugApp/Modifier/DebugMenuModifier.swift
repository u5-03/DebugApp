//
//  DebugMenu.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import SwiftUI

struct DebugMenuModifier: ViewModifier {

    @Binding var shouldShow: Bool
    private var actionSheetButtonList: [ActionSheet.Button] {
        let apiList = [
            ActionSheet.Button.default(Text("API"), action: {
                UserDefaults.standard.set(nil, forKey: MockType.userDefaultKey)
                DependencyModules.refreshModule()
            })
        ]
        let mockList = MockType.allCases.map({ type in
            ActionSheet.Button.default(Text(type.rawValue)) {
                UserDefaults.standard.set(type.rawValue, forKey: MockType.userDefaultKey)
                DependencyModules.refreshModule()
            }
        })
        return apiList + mockList + [.cancel()]
    }

    func body(content: Content) -> some View {
        ZStack {
            content
                .actionSheet(isPresented: _shouldShow, content: {
                    ActionSheet(title: Text("Mock change"), message: nil, buttons:
                        actionSheetButtonList
                    )
                })
        }
    }
}

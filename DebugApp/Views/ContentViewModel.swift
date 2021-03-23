//
//  ContentViewModel.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import Foundation
import Combine

final class ContentViewModel: NSObject, ObservableObject {
    @Published private(set) var colorList: [ColorModel] = []
    @Published var errorMessage: ErrorMessage?
    @Published private var mockType: MockType = .default
    @Inject private var mockService: MockProtocol
    private var cancellableSet = Set<AnyCancellable>()

    override init() {
        super.init()
        DependencyModules.refreshModule()
    }

    func refreshList() {
        mockService.fetchColorList { [weak self] response in
            switch response {
            case .success(let list):
                self?.colorList = list
            case .failure(let error):
                if case MockError.mockError(let message) = error {
                    self?.errorMessage = ErrorMessage(message: message)
                } else {
                    self?.errorMessage = ErrorMessage(message: error.localizedDescription)
                }
            }
        }
    }
}

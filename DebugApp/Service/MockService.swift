//
//  MockService.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import UIKit

enum MockType: String, CaseIterable {
    static let userDefaultKey = "MockTypeKey"
    static let `default`: MockType = .randomList

    case randomList
    case randomListWithSameColor
    case randomListWithShortText
    case randomListWithDelay
    case single
    case empty
    case error
    case congratulation
}

enum MockError: Error, Equatable {
    case mockError(message: String)
}

struct ErrorMessage: Identifiable {
    var id: String {
        return message
    }
    let message: String
}

final class MockService: MockProtocol {
    private let mockType: MockType

    init(mockType: MockType) {
        self.mockType = mockType
    }

    func fetchColorList(completion: @escaping (Result<[ColorModel], Error>) -> Void) {
        switch mockType {
        case .randomList:
            let list = [Int](0...Int.random(in: 1...100))
                .map({ _ in ColorModel(text: .randomQuotations, color: .random) })
            completion(.success(list))
        case .randomListWithSameColor:
            let color = UIColor.random
            let list = [Int](0...Int.random(in: 1...100))
                .map({ _ in ColorModel(text: .randomQuotations, color: color) })
            completion(.success(list))
        case .randomListWithShortText:
            let list = [Int](0...Int.random(in: 1...100))
                .map({ _ in ColorModel(text: String.random(length: 1), color: .random) })
            completion(.success(list))
        case .randomListWithDelay:
            let list = [Int](0...Int.random(in: 1...100))
                .map({ _ in ColorModel(text: .randomQuotations, color: .random) })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(.success(list))
            }
        case .single:
            completion(.success([.init(text: .randomQuotations, color: .random)]))
        case .empty:
            completion(.success([]))
        case .error:
            completion(.failure(MockError.mockError(message: "This is Error(Mock)")))
        case .congratulation:
            let list = [Int](0...Int.random(in: 10...100))
                .map({ _ in ColorModel(text: "おめでとう", color: .random) })
            completion(.success(list))
        }
    }
}

//
//  APIService.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import UIKit


final class APIService: MockProtocol {
    func fetchColorList(completion: @escaping (Result<[ColorModel], Error>) -> Void) {
        let list = [Int](0...Int.random(in: 1...100))
            .map({ _ in ColorModel(text: "API Response", color: .random) })
        completion(.success(list))
    }
}

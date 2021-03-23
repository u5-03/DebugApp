//
//  MockProtocol.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import Foundation

protocol MockProtocol {
    func fetchColorList(completion: @escaping (Result<[ColorModel], Error>) -> Void)
}

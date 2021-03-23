//
//  DebugAppTests.swift
//  DebugAppTests
//
//  Created by Yugo Sugiyama on 2021/03/24.
//

import XCTest
@testable import DebugApp

class DebugAppTests: XCTestCase {

    override func setUpWithError() throws {
        DependencyModules.resetModule()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMultiList() throws {
        let viewModel = ContentViewModel()
        let module = Module { () -> MockProtocol in
            return MockService(mockType: .randomList)
        }
        Dependencies.root.add(module: module)
        viewModel.refreshList()
        XCTAssertGreaterThanOrEqual(viewModel.colorList.count, 1)
    }

    func testSingleList() throws {
        let viewModel = ContentViewModel()
        let module = Module { () -> MockProtocol in
            return MockService(mockType: .single)
        }
        Dependencies.root.add(module: module)
        viewModel.refreshList()
        XCTAssertEqual(viewModel.colorList.count, 1)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testEmptyList() {
        let viewModel = ContentViewModel()
        let module = Module { () -> MockProtocol in
            return MockService(mockType: .empty)
        }
        Dependencies.root.add(module: module)
        viewModel.refreshList()
        XCTAssertEqual(viewModel.colorList.count, 0)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testError() {
        let viewModel = ContentViewModel()
        let module = Module { () -> MockProtocol in
            return MockService(mockType: .error)
        }
        Dependencies.root.add(module: module)
        viewModel.refreshList()
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

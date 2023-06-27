//
//  VersionTestCase.swift
//  Tests
//
//  Created by Mc Kevin on 11/06/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Alamofire
import Combine
@testable import CoreDecele
import Decele
import Mocker
import XCTest

final class VersionTestCase: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        RepositorySetting.shared = RepositorySetting(baseURL: "http://localhost:3000")
        var mock = Mock(url: String.authVersion, data: [.get: .versionJson])
        mock.delay = .seconds(1)
        mock.register()
    }

    override func tearDownWithError() throws {
        Mocker.removeAll()
    }

    func testRequestVersion() throws {
        let exp = expectation(description: "Validating Version")
        VersionRequest().resolve(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Request completed successfully.")
            case let .failure(error):
                print("Request failed with error: \(error)")
                XCTFail()
            }
            exp.fulfill()
        }, receiveValue: { data in
            // Aquí puedes trabajar con los datos recibidos
            print("Received data: \(data)")
            XCTAssertNotNil(data.version, "version not nil")
        }).store(in: &cancellables)
        waitForExpectations(timeout: 20)
    }
}

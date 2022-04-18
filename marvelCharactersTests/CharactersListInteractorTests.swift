//
//  CharactersListInteractorTests.swift
//  marvelCharactersTests
//
//  Created by Leticia Echarri on 18/4/22.
//

import XCTest
@testable import marvelCharacters

class CharactersListInteractorTests: XCTestCase {
    let datasourceMock = CharactersListDataSourceMock()
    var interactor: CharactersListInteractor?
    
    override func setUp() {
        interactor = CharactersListInteractor(datasourceMock)
    }
    
    override func tearDown() {
        interactor = nil
    }

    func test_characterslistInteractor_getcharacters_success() {
        let expect = self.expectation(description: #function)
        interactor?.getCharacters(with: nil, parameters: nil) { result in
            XCTAssertEqual(result.count, 2)
            expect.fulfill()
        } failure: { error in }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error)
            XCTAssertTrue(self.datasourceMock.isRequestCalled)
        }
    }
    
    func test_characterslistInteractor_getcharacters_failure() {
        datasourceMock.isSuccess = false
        
        let expect = self.expectation(description: #function)
        interactor?.getCharacters(with: nil, parameters: nil) { result in
        } failure: { error in
            XCTAssertEqual(error.localizedDescription, "Data was not retrieved from request")
            expect.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error)
            XCTAssertTrue(self.datasourceMock.isRequestCalled)
        }
    }

}

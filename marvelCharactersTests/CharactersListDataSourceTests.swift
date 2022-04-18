//
//  CharactersListDataSourceTests.swift
//  marvelCharactersTests
//
//  Created by Leticia Echarri on 13/4/22.
//

import XCTest
@testable import marvelCharacters

class CharactersListDataSourceTests: XCTestCase {
    var dataSourceMock = DataSourceMock()
    var datasource: CharactersListDataSource?
    
    override func setUp() {
        datasource = CharactersListDataSource(dataSourceMock)
    }
    
    override func tearDown() {
        datasource = nil
    }
    
    func test_characterslistdatasource_getcharacters_success() {
        let expect = self.expectation(description: #function)
        datasource?.getCharacters(with: nil, parameters: nil) { model in
            XCTAssertEqual(model.data.results.count, 2)
            expect.fulfill()
        } failure: { error in }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error)
            XCTAssertTrue(self.dataSourceMock.isRequestCalled)
        }
    }
    
    func test_characterslistdatasource_getcharacters_failure() {
        dataSourceMock.isSuccess = false
        
        let expect = self.expectation(description: #function)
        datasource?.getCharacters(with: nil, parameters: nil) { model in
        } failure: { error in
            XCTAssertEqual(error.localizedDescription, "Data was not retrieved from request")
            expect.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error)
            XCTAssertTrue(self.dataSourceMock.isRequestCalled)
        }
    }
    
    func test_characterslistdatasource_getcharacters_success_error() {
        dataSourceMock.hasModelError = true
        
        let expect = self.expectation(description: #function)
        datasource?.getCharacters(with: nil, parameters: nil) { model in
        } failure: { error in
            XCTAssertEqual(error.localizedDescription, "Error")
            expect.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error)
            XCTAssertTrue(self.dataSourceMock.isRequestCalled)
        }
    }
    
    func test_characterslistdatasource_getcharacters_success_dataerror() {
        dataSourceMock.hasDataError = true
        
        let expect = self.expectation(description: #function)
        datasource?.getCharacters(with: nil, parameters: nil) { model in
        } failure: { error in
            XCTAssertEqual(error.localizedDescription, "Data was not retrieved from request")
            expect.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error)
            XCTAssertTrue(self.dataSourceMock.isRequestCalled)
        }
    }
}

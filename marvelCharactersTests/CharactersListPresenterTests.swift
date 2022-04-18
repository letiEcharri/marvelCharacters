//
//  CharactersListPresenterTests.swift
//  marvelCharactersTests
//
//  Created by Leticia Echarri on 13/4/22.
//

import XCTest
@testable import marvelCharacters

class CharactersListPresenterTests: XCTestCase {
    let delegateMock = CharactersListNavigationDelegateMock()
    let interactorMock = CharactersListInteractorMock()
    let viewDelegateMock = CharactersListPresenterDelegateMock()
    var presenter: CharactersListPresenter?
    
    override func setUp() {
        interactorMock.dataSource = CharactersListDataSourceMock()
        presenter = CharactersListPresenter(navigationDelegate: delegateMock, interactor: interactorMock)
        presenter?.viewDelegate = viewDelegateMock
    }
    
    override func tearDown() {
        presenter = nil
    }

    func test_presenter_viewdidload_when_getcharacters_success() {
        presenter?.viewDidLoad()
    
        XCTAssert(interactorMock.isGetCharactersCalled)
    }
    
    func test_presenter_viewdidload_when_getcharacters_fails() {
        interactorMock.dataSource?.isSuccess = false
        
        presenter?.viewDidLoad()
        
        XCTAssert(interactorMock.hasError)
        XCTAssert(viewDelegateMock.isLoadingHidden)
        XCTAssert(viewDelegateMock.isAlertShown)
        XCTAssertEqual(viewDelegateMock.message, "Data was not retrieved from request")
    }
    
    func test_presenter_viewdidload_when_getcharacters_isEmpty() {
        interactorMock.dataSource?.isEmpty = true
                
        presenter?.viewDidLoad()
        
        XCTAssertEqual(presenter?.characters.count, 0)
        XCTAssert(viewDelegateMock.isLoadingShown)
        XCTAssert(viewDelegateMock.isLoadingHidden)
        XCTAssert(viewDelegateMock.isMessageShown)
        XCTAssertEqual(viewDelegateMock.message, "SIN RESULTADOS")
    }

    func test_presenter_didSelected_when_isSuccess() {
        presenter?.viewDidLoad()
        interactorMock.isGetCharactersCalled = false
        presenter?.didSelect(row: 0)
        
        XCTAssert(interactorMock.isGetCharactersCalled)
        XCTAssert(delegateMock.isNavigateToCalled)
    }
    
    func test_presenter_didSelected_when_fails() {
        presenter?.viewDidLoad()
        interactorMock.isGetCharactersCalled = false
        interactorMock.dataSource?.isSuccess = false
        presenter?.didSelect(row: 0)
        
        XCTAssert(interactorMock.isGetCharactersCalled)
        XCTAssert(interactorMock.hasError)
        XCTAssert(viewDelegateMock.isLoadingHidden)
        XCTAssert(viewDelegateMock.isAlertShown)
        XCTAssertEqual(viewDelegateMock.message, "Data was not retrieved from request")
    }
    
    func test_presenter_search_when_name_is_passed() {
        presenter?.search(text: "Abomination")
        
        if let datasource = interactorMock.dataSource {
            XCTAssert(datasource.isRequestCalled)
        }
        XCTAssert(interactorMock.isGetCharactersCalled)
        XCTAssertEqual(presenter?.characters.count, 1)
        XCTAssertEqual(presenter?.characters[0].title, "Abomination (Emil Blonsky)")
    }
}

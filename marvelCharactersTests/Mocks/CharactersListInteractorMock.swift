//
//  CharactersListInteractorMock.swift
//  marvelCharactersTests
//
//  Created by Leticia Echarri on 12/4/22.
//

import Foundation
@testable import marvelCharacters

class CharactersListInteractorMock: CharactersListInteractorProtocol {
    var dataSource: CharactersListDataSourceMock?
    var isGetCharactersCalled: Bool = false
    var hasError = false
    
    func getCharacters(with identifier: Int?, parameters: [String : String]?, success: @escaping CharactersListResponseBlock, failure: @escaping FailureCompletionBlock) {
        isGetCharactersCalled = true
        if let dataSource = dataSource {
            dataSource.getCharacters(with: identifier, parameters: parameters, success: { model in
                success(model.data.results)
            }, failure: { error in 
                self.hasError = true
                failure(error)
            })
        }
    }
}

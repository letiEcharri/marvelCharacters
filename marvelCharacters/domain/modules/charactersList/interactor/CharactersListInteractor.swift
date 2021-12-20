//
//  CharactersListInteractor.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

class CharactersListInteractor: CharactersListInteractorProtocol {
    
    private let datasource: CharactersListDataSourceProtocol = CharactersListDataSource()
    
    func getCharacters(with id: Int?, parameters: [String : String]?, success: @escaping CharactersListResponseBlock, failure: @escaping FailureCompletionBlock) {
        
        datasource.getCharacters(with: id, parameters: parameters, success: { model in
            success(model.data.results)
            
        }, failure: failure)
    }
}

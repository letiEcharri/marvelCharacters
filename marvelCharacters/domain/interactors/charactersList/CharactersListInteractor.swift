//
//  CharactersListInteractor.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

class CharactersListInteractor: CharactersListInteractorProtocol {
    
    private var datasource: CharactersListDataSourceProtocol
    
    init(_ datasource: CharactersListDataSourceProtocol) {
        self.datasource = datasource
    }
    
    func getCharacters(with identifier: Int?, parameters: [String : String]?, success: @escaping CharactersListResponseBlock, failure: @escaping FailureCompletionBlock) {
        
        datasource.getCharacters(with: identifier, parameters: parameters, success: { model in
            success(model.data.results)
            
        }, failure: failure)
    }
}

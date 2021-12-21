//
//  CharactersListDataSource.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

class CharactersListDataSource: CharactersListDataSourceProtocol, DataSource {
    
    func getCharacters(with identifier: Int?, parameters: [String: String]?, success: @escaping CharactersResponseBlock, failure: @escaping FailureCompletionBlock) {
        
        executeRequest(from: .characters, identifier: identifier, parameters: parameters, success: { response in
            if let data = response as? Data {
                
                if let characters = try? JSONDecoder().decode(CharactersModel.self, from: data) {
                    success(characters)
                    return
                    
                } else if let error = try? JSONDecoder().decode(MarvelErrorModel.self, from: data) {
                    let nserror = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : error.message]) as Error
                    failure(nserror)
                    return
                }
            }
            
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
            failure(error)
            
        }, failure: failure)
    }
}

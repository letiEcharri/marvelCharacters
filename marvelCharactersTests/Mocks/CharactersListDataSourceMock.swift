//
//  CharactersListDataSourceMock.swift
//  marvelCharactersTests
//
//  Created by Leticia Echarri on 11/4/22.
//

import Foundation
@testable import marvelCharacters

class CharactersListDataSourceMock: CharactersListDataSourceProtocol {
    var isRequestCalled = false
    var isSuccess = true
    var isEmpty = false
    
    func getCharacters(with identifier: Int?, parameters: [String : String]?, success: @escaping CharactersResponseBlock, failure: @escaping FailureCompletionBlock) {
        isRequestCalled = true
        if isSuccess,
           let model = getCharactersModel(with: identifier, parameters: parameters) {
            success(model)
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
            failure(error)
        }
    }
}

private extension CharactersListDataSourceMock {
    func getCharactersModel(with identifier: Int?, parameters: [String : String]?) -> CharactersModel? {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "characters", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                var characters = try JSONDecoder().decode(CharactersModel.self, from: jsonData)
                
                var items: [CharactersResult] = characters.data.results
                if let identifier = identifier {
                    items = items.filter({ $0.identifier == identifier })
                }
                if let parameters = parameters,
                    let name = parameters[CharacterParameters.nameStartsWith.rawValue] {
                    items = items.filter({ $0.name.range(of: name) != nil })
                }
                
                characters.data.results = isEmpty ? [] : items
                
                return characters
            } catch {
                return nil
            }
        }
        return nil
    }
}

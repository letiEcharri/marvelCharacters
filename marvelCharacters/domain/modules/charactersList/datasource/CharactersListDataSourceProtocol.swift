//
//  CharactersListDataSourceProtocol.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

typealias CharactersResponseBlock = (CharactersModel) -> Void

protocol CharactersListDataSourceProtocol {
    func getCharacters(with id: Int?, parameters: [String: String]?, success: @escaping CharactersResponseBlock, failure: @escaping FailureCompletionBlock)
}

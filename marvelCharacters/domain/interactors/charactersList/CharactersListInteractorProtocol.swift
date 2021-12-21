//
//  CharactersListInteractorProtocol.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

typealias CharactersListResponseBlock = ([CharactersResult]) -> Void

protocol CharactersListInteractorProtocol {
    func getCharacters(with identifier: Int?, parameters: [String: String]?, success: @escaping CharactersListResponseBlock, failure: @escaping FailureCompletionBlock)
}

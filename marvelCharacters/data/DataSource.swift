//
//  DataSource.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

typealias SuccessCompletionBlock = (_ object: AnyObject) -> Void
typealias FailureCompletionBlock = (_ error: Error) -> Void

enum DataSourceModule: String {
    case characters = "/characters"
}

protocol DataSource {
    func executeRequest(from module: DataSourceModule, identifier: Int?, parameters: [String: Any]?, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
}

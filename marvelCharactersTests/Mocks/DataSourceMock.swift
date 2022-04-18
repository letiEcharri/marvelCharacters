//
//  DataSourceMock.swift
//  marvelCharactersTests
//
//  Created by Leticia Echarri on 13/4/22.
//

import Foundation
@testable import marvelCharacters

class DataSourceMock: DataSource {
    var isRequestCalled = false
    var isSuccess = true
    var hasModelError = false
    var hasDataError = false
    
    func executeRequest(from module: DataSourceModule, identifier: Int?, parameters: [String : Any]?, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        self.isRequestCalled = true
        
        if isSuccess {
            if hasDataError {
                if let dataError = "" as AnyObject? {
                    success(dataError)
                }
            }
            let data = getDataFromJson()
            if let result = data as AnyObject? {
                success(result)
            }
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
            failure(error)
        }
    }
}

private extension DataSourceMock {
    func getDataFromJson() -> Data? {
        if hasModelError {
            return getErrorJsonString().data(using: .utf8)
        }
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "characters", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return nil
            }
        }
        return nil
    }
    
    
    func getErrorJsonString() -> String {
        return """
        {
            "code": "500",
            "message": "Error"
        }
        """
    }
}

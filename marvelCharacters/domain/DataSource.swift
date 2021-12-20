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
    func executeRequest(from module: DataSourceModule, id: Int?, parameters: [String: Any]?, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
}

extension DataSource {
    
    private var urlBase: String {
        "http://gateway.marvel.com/v1/public"
    }
    
    private var publicKey: String {
        ""
    }
    
    private var privateKey: String {
        ""
    }
    
    private func getQueryItems() -> [URLQueryItem] {
        
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = (timestamp + privateKey + publicKey).toMD5()
        
        return [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]
    }
    
    func executeRequest(from module: DataSourceModule, id: Int?, parameters: [String: Any]?, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        
        var urlBaseString = urlBase + module.rawValue
        
        if let characterID = id {
            urlBaseString += "/\(String(characterID))"
        }
        
        guard var urlComponents = URLComponents(string: urlBaseString) else {
            return
        }
        var queryItems: [URLQueryItem] = [URLQueryItem]()
        
        if let parameters = parameters {
            let items = parameters.compactMap { (key, value) in
                URLQueryItem(name: key, value: value as? String)
            }
            queryItems = items
        }
        queryItems.append(contentsOf: getQueryItems())
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        config.timeoutIntervalForResource = 20.0
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    failure(error)
                } else if let jsonData = responseData {
                    success(jsonData as AnyObject)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    failure(error)
                }
            }
        }
        
        task.resume()
        
    }
}

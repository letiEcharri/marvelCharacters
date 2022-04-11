//
//  URL+DownloadImages.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 18/4/22.
//

import Foundation

extension URL {
    func downloadImage(completion: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: self) { data, _, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async { // execute on main thread
                completion(data)
            }
        }

        task.resume()
    }
}

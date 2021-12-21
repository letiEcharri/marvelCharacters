//
//  MarvelErrorModel.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

struct MarvelErrorModel: Decodable {
    let code: String
    let message: String
}

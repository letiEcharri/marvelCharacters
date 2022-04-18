//
//  CharactersModel.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

// MARK: - CharactersModel
struct CharactersModel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    var data: CharactersDataClass
}

// MARK: - DataClass
struct CharactersDataClass: Codable {
    let offset, limit, total, count: Int
    var results: [CharactersResult]
}

// MARK: - Result
struct CharactersResult: Codable {
    let identifier: Int
    let name, resultDescription: String
    let modified: String
    let thumbnail: CharactersThumbnail
    let resourceURI: String
    let comics, series: CharactersComics
    let stories: CharactersStories
    let events: CharactersComics
    let urls: [CharactersURLElement]

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Comics
struct CharactersComics: Codable {
    let available: Int
    let collectionURI: String
    let items: [CharactersComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct CharactersComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct CharactersStories: Codable {
    let available: Int
    let collectionURI: String
    let items: [CharactersStoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct CharactersStoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String
}

// MARK: - Thumbnail
struct CharactersThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct CharactersURLElement: Codable {
    let type: String
    let url: String
}

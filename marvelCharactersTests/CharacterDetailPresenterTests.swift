//
//  CharacterDetailPresenterTests.swift
//  marvelCharactersTests
//
//  Created by Leticia Echarri on 18/4/22.
//

import XCTest
@testable import marvelCharacters

class CharacterDetailPresenterTests: XCTestCase {
    func test_presenter_init() {
        let model = CharacterDetailViewController.Model(imageURL: .init(fileURLWithPath: ""),
                                                        name: "Thor",
                                                        sections: [])
        let presenter = CharacterDetailPresenter(viewModel: model)
        XCTAssertEqual(presenter.viewModel.name, model.name)
    }
}

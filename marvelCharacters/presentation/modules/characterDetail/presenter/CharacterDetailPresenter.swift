//
//  CharacterDetailPresenter.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 21/12/21.
//

import Foundation

class CharacterDetailPresenter: BasePresenter, CharacterDetailPresenterProtocol {
    
    // MARK: - Properties
    weak var viewDelegate: CharacterDetailPresenterDelegate?
    var viewModel: CharacterDetailViewController.Model
    
    // MARK: - Initialization
    
    init(viewModel: CharacterDetailViewController.Model) {
        self.viewModel = viewModel
    }
}

//
//  CharacterDetailPresenterProtocol.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 21/12/21.
//

import Foundation

protocol CharacterDetailPresenterProtocol where Self: BasePresenter {
    var ui: CharacterDetailPresenterDelegate? { get set }
    var viewModel: CharacterDetailViewController.Model { get set }
}

protocol CharacterDetailPresenterDelegate: BasePresenterDelegate {
}

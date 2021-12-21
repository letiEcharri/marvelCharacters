//
//  CharactersListPresenterProtocol.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

enum CharactersListSignal {
    case detail(_ model: CharacterDetailViewController.Model)
}

protocol CharactersListSignalDelegate: AnyObject {
    func handle(_ signal: CharactersListSignal)
}

protocol CharactersListPresenterProtocol where Self: BasePresenter {
    var ui: CharactersListPresenterDelegate? { get set }
    var characters: [CharactersListCell.Model] { get set }
    
    func search(text: String)
    func didSelect(row: Int)
}

protocol CharactersListPresenterDelegate: BasePresenterDelegate {
    func show(message: String)
    func showLoading()
    func hideLoading()
    func showAlert(title: String, message: String)
}

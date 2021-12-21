//
//  CharactersListPresenterProtocol.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

enum CharactersListNavigation {
    case detail(_ model: CharacterDetailViewController.Model)
}

protocol CharactersListNavigationDelegate: AnyObject {
    func navigate(to navigation: CharactersListNavigation)
}

protocol CharactersListPresenterProtocol where Self: BasePresenter {
    var viewDelegate: CharactersListPresenterDelegate? { get set }
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

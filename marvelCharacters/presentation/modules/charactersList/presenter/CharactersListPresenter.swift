//
//  CharactersListPresenter.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

class CharactersListPresenter: BasePresenter, CharactersListPresenterProtocol {
    
    // MARK: - Properties
    
    var viewDelegate: CharactersListPresenterDelegate?
    var characters: [CharactersListCell.Model] = [CharactersListCell.Model]()
    
    private weak var navigationDelegate: CharactersListNavigationDelegate?
    private let interactor: CharactersListInteractorProtocol
    
    // MARK: - Initialization
    
    init(navigationDelegate: CharactersListNavigationDelegate, interactor: CharactersListInteractorProtocol) {
        self.navigationDelegate = navigationDelegate
        self.interactor = interactor
    }
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for 50 chartacters from Avengers series to init the page
        let parameters: [String: String] = [
            CharacterParameters.series.rawValue: "354",
            CharacterParameters.limit.rawValue: "50"
        ]
        
        getCharacters(parameters: parameters)
    }
    
    func search(text: String) {
        let parameters = [CharacterParameters.nameStartsWith.rawValue: text]
        
        getCharacters(parameters: parameters)
    }
    
    func didSelect(row: Int) {
        let item = characters[row]
        getCharacterDetail(with: item.identifier)
    }
    
    private func getCharacters(parameters: [String: String]?) {
        
        characters.removeAll()
        
        viewDelegate?.showLoading()
        
        interactor.getCharacters(with: nil, parameters: parameters) { [weak self] response in
            response.forEach { item in
                if let url = URL(string: item.thumbnail.path + "." + item.thumbnail.thumbnailExtension) {
                    self?.characters.append(.init(title: item.name, imageURL: url, identifier: item.identifier))
                }
            }
            DispatchQueue.main.async {
                self?.viewDelegate?.reloadData()
            }
            self?.viewDelegate?.hideLoading()
            if self?.characters.count == 0 {
                self?.viewDelegate?.show(message: "SIN RESULTADOS")
            }
            
        } failure: { [weak self] error in
            self?.viewDelegate?.hideLoading()
            self?.viewDelegate?.showAlert(title: "ERROR", message: error.localizedDescription)
        }
    }
    
    private func getCharacterDetail(with identifier: Int) {
        viewDelegate?.showLoading()
        
        interactor.getCharacters(with: identifier, parameters: nil) { [weak self] response in
            self?.viewDelegate?.hideLoading()
            if let character = response.first,
                let url = URL(string: character.thumbnail.path + "." + character.thumbnail.thumbnailExtension) {
                
                let comicsItems = character.comics.items.compactMap { item in
                    item.name
                }
                let seriesItems = character.series.items.compactMap { item in
                    item.name
                }
                
                let comics = CharacterDetailViewController.Model.Section(name: "Comics", items: comicsItems)
                let series = CharacterDetailViewController.Model.Section(name: "Series", items: seriesItems)
                let description = CharacterDetailViewController.Model.Section(name: "Descipción", items: [character.resultDescription])
                
                self?.navigationDelegate?.navigate(to: .detail(.init(imageURL: url,
                                                                    name: character.name,
                                                                    sections: [description, comics, series])))
            }
            
        } failure: { [weak self] error in
            self?.viewDelegate?.hideLoading()
            self?.viewDelegate?.showAlert(title: "ERROR", message: error.localizedDescription)
        }

    }
}

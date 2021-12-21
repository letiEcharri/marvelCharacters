//
//  CharactersListPresenter.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import UIKit

class CharactersListPresenter: BasePresenter, CharactersListPresenterProtocol {
    
    // MARK: - Properties
    
    var ui: CharactersListPresenterDelegate?
    var characters: [CharactersListCell.Model] = [CharactersListCell.Model]()
    
    private var signalDelegate: CharactersListSignalDelegate
    private let interactor: CharactersListInteractorProtocol
    
    // MARK: - Initialization
    
    init(signalDelegate: CharactersListSignalDelegate, interactor: CharactersListInteractorProtocol) {
        self.signalDelegate = signalDelegate
        self.interactor = interactor
    }
    
    // MARK: - Functions
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    
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
        getCharacterDetail(with: item.id)
    }
    
    private func getCharacters(parameters: [String: String]?) {
        
        characters.removeAll()
        
        ui?.showLoading()
        
        interactor.getCharacters(with: nil, parameters: parameters) { [weak self] response in
            
            let group = DispatchGroup()
            
            response.forEach { [weak self] item in
                group.enter()
                if let url = URL(string: item.thumbnail.path + "." + item.thumbnail.thumbnailExtension) {
                    url.downloadImage { data in
                        self?.characters.append(CharactersListCell.Model(title: item.name,
                                                                         image: UIImage(data: data) ?? UIImage(),
                                                                         id: item.id))
                        group.leave()
                    }
                }
            }
            
            group.notify(queue: .main) {
                self?.ui?.reloadData()
                self?.ui?.hideLoading()
                if self?.characters.count == 0 {
                    self?.ui?.show(message: "SIN RESULTADOS")
                }
            }
            
        } failure: { [weak self] error in
            self?.ui?.hideLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.ui?.showAlert(title: "ERROR", message: error.localizedDescription)
            }
        }
    }
    
    private func getCharacterDetail(with id: Int) {
        ui?.showLoading()
        
        interactor.getCharacters(with: id, parameters: nil) { [weak self] response in
            
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
                
                url.downloadImage { data in
                    self?.ui?.hideLoading()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self?.signalDelegate.handle(.detail(.init(image: UIImage(data: data) ?? UIImage(),
                                                                  name: character.name,
                                                                  sections: [description, comics, series])))
                    }
                }
            }
            
        } failure: { [weak self] error in
            self?.ui?.hideLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.ui?.showAlert(title: "ERROR", message: error.localizedDescription)
            }
        }

    }
}

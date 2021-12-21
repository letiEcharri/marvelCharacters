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
                                                                         image: UIImage(data: data) ?? UIImage()))
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
}

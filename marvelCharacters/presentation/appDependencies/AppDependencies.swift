//
//  AppDependencies.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

class AppDependencies: AppDependenciesProtocol {
    
    func makeCharactersListView(signalDelegate: CharactersListSignalDelegate) -> CharactersListViewController {
        let interactor = CharactersListInteractor()
        let presenter = CharactersListPresenter(signalDelegate: signalDelegate, interactor: interactor)
        let viewController = CharactersListViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
    
    func makeCharacterDetailView(viewModel: CharacterDetailViewController.Model) -> CharacterDetailViewController {
        let presenter = CharacterDetailPresenter(viewModel: viewModel)
        let viewController = CharacterDetailViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
}

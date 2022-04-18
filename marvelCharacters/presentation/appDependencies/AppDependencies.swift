//
//  AppDependencies.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

class AppDependencies: AppDependenciesProtocol {
    
    func makeCharactersListView(navigationDelegate: CharactersListNavigationDelegate) -> CharactersListViewController {
        let datasource = CharactersListDataSource(BaseProvider())
        let interactor = CharactersListInteractor(datasource)
        let presenter = CharactersListPresenter(navigationDelegate: navigationDelegate, interactor: interactor)
        let viewController = CharactersListViewController(presenter)
        
        presenter.viewDelegate = viewController
        
        return viewController
    }
    
    func makeCharacterDetailView(viewModel: CharacterDetailViewController.Model) -> CharacterDetailViewController {
        let presenter = CharacterDetailPresenter(viewModel: viewModel)
        let viewController = CharacterDetailViewController(presenter)
                
        return viewController
    }
}

//
//  AppCoordinator.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import UIKit

protocol Coordinator {
    func resolve()
}

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
            
    var navigationController: UINavigationController?
    var window: UIWindow
    let appDependencies: AppDependenciesProtocol
    
    // MARK: - Init
    
    init(_ window: UIWindow, appDependencies: AppDependenciesProtocol = AppDependencies()) {
        self.window = window
        self.appDependencies = appDependencies
    }
    
    // MARK: - Coordinator
    
    func resolve() {
        let viewController = appDependencies.makeCharactersListView(signalDelegate: self)
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController?.modalPresentationStyle = .fullScreen
        window.rootViewController = navigationController
    }
}

// MARK: - CharactersList Signal Delegate

extension AppCoordinator: CharactersListSignalDelegate {
    func handle(_ signal: CharactersListSignal) {
        
    }
}

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
    
    // MARK: - Init
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Coordinator
    
    func resolve() {
        let viewController = ViewController()
        navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
}

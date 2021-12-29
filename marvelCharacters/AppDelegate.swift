//
//  AppDelegate.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        if let window = window {
            coordinator = AppCoordinator(window)
            coordinator?.resolve()
        }
        
        customizeNavigationBar()
        
        return true
    }
    
    private func customizeNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .orange // Items
        navigationBarAppearace.barTintColor = .red // Background
        navigationBarAppearace.backgroundColor = .red
        navigationBarAppearace.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ] // Title
    }
}

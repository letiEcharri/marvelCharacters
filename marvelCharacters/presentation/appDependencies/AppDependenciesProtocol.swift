//
//  AppDependenciesProtocol.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import UIKit

protocol AppDependenciesProtocol {
    func makeCharactersListView(signalDelegate: CharactersListSignalDelegate) -> CharactersListViewController
}

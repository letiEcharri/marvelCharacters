//
//  CharactersListNavigationDelegateMock.swift
//  marvelCharactersTests
//
//  Created by Leticia Echarri on 12/4/22.
//

import Foundation
@testable import marvelCharacters

class CharactersListNavigationDelegateMock: CharactersListNavigationDelegate {
    var isNavigateToCalled: Bool = false
    
    func navigate(to navigation: CharactersListNavigation) {
        isNavigateToCalled = true
    }
}

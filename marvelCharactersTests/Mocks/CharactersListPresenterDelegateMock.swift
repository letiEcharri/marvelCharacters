//
//  CharactersListPresenterDelegateMock.swift
//  marvelCharactersTests
//
//  Created by Leticia Echarri on 12/4/22.
//

import Foundation
@testable import marvelCharacters

class CharactersListPresenterDelegateMock: CharactersListPresenterDelegate {
    var isMessageShown: Bool = false
    var isLoadingShown: Bool = false
    var isLoadingHidden: Bool = false
    var isAlertShown: Bool = false
    var isDataReloaded: Bool = false
    var message = ""
    
    func show(message: String) {
        isMessageShown = true
        self.message = message
    }
    
    func showLoading() {
        isLoadingShown = true
    }
    
    func hideLoading() {
        isLoadingHidden = true
    }
    
    func showAlert(title: String, message: String) {
        isAlertShown = true
        self.message = message
    }
    
    func reloadData() {
        isDataReloaded = true
    }
}

//
//  BasePresenter.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import Foundation

class BasePresenter {
    
    func viewWillAppear() {}
        
    func viewDidLoad() {}
    
    func viewDidAppear() {}
    
    func viewDidDisappear() {}
}

protocol BasePresenterDelegate: AnyObject {
    func reloadData()
}

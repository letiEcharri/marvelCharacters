//
//  BaseViewController.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 13/4/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var spinnerView: SpinnerView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showSpinner() {
        spinnerView = SpinnerView()
        if let spinnerView = spinnerView {
            spinnerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(spinnerView)
            NSLayoutConstraint.activate([
                spinnerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                spinnerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                spinnerView.leftAnchor.constraint(equalTo: view.leftAnchor),
                spinnerView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        }
    }
    
    func hideSpinner() {
        spinnerView?.removeFromSuperview()
    }

}

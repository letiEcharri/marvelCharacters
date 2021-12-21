//
//  CharacterDetailCell.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 21/12/21.
//

import UIKit

class CharacterDetailCell: UITableViewCell {

    static var identifier: String {
        "CharacterDetailCell"
    }
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    func set(text: String) {
        descriptionLabel.text = text
        
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }

}

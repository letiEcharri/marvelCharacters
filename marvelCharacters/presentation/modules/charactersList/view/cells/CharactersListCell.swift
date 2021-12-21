//
//  CharactersListCell.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import UIKit

class CharactersListCell: UITableViewCell {
    
    static var identifier: String {
        "CharactersListCell"
    }
    
    struct Model {
        let title: String
        let image: UIImage
        let id: Int
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        return label
    }()
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        return imageView
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .top
        
        return stack
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            image,
            verticalStackView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        
        return stack
    }()
    
    func set(with model: Model) {
        selectionStyle = .none
        image.image = model.image
        titleLabel.text = model.title
        
        addSubview(self.horizontalStackView)
        NSLayoutConstraint.activate([
            self.horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}

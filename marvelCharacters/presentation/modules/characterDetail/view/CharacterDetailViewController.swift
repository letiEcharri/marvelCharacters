//
//  CharacterDetailViewController.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 21/12/21.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    struct Model {
        let image: UIImage
        let name: String
        let sections: [Section]
        
        struct Section {
            let name: String
            let items: [String]
        }
    }
    
    // MARK: - Views
    
    lazy var picture: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        
        table.register(CharacterDetailCell.self, forCellReuseIdentifier: CharacterDetailCell.identifier)
        
        return table
    }()
    
    // MARK: - Properties
    
    private var viewModel: Model?
    
    private let presenter: CharacterDetailPresenterProtocol
    
    // MARK: - Initialization
    
    init(_ presenter: CharacterDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup UI
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        viewModel = presenter.viewModel
        if let viewModel = viewModel {
            title = viewModel.name.uppercased()
            navigationController?.setNavigationBarHidden(false, animated: true)
            picture.image = viewModel.image
        }
        
        view.addSubview(picture)
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            picture.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: picture.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}

// MARK: - CharacterDetailPresenterDelegate

extension CharacterDetailViewController: CharacterDetailPresenterDelegate {
    func reloadData() {}
}

// MARK: - Table Delegate & Datasource

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let viewModel = viewModel {
            return viewModel.sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.sections[section].items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailCell.identifier, for: indexPath) as? CharacterDetailCell else {
            return UITableViewCell()
        }
        
        if let viewModel = viewModel {
            let section = viewModel.sections[indexPath.section]
            let description = section.items[indexPath.row]
            cell.set(text: !description.isEmpty ? description : "---")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let viewModel = viewModel {
            return viewModel.sections[section].name.uppercased()
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

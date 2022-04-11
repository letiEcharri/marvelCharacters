//
//  CharactersListViewController.swift
//  marvelCharacters
//
//  Created by Leticia Echarri on 20/12/21.
//

import UIKit

class CharactersListViewController: BaseViewController {
    
    struct Model {
        let characters: [CharactersListCell.Model]
    }
    
    // MARK: - Views
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundColor = .red
        bar.frame = CGRect(x: 0, y: 0, width: 70, height: 50)
        bar.delegate = self
        
        return bar
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.rowHeight = 80
        table.separatorStyle = .none
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.tableHeaderView = searchBar
        
        table.register(CharactersListCell.self, forCellReuseIdentifier: CharactersListCell.identifier)
        
        return table
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    // MARK: - Properties
    
    var characters: [CharactersListCell.Model] = [CharactersListCell.Model]()
    
    private let presenter: CharactersListPresenterProtocol
    
    // MARK: - Initialization
    
    init(_ presenter: CharactersListPresenterProtocol) {
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
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = .white
        title = "PERSONAJES"
        
        self.view.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        messageLabel.isHidden = true
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}

// MARK: - Table Delegate & Datasource

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersListCell.identifier, for: indexPath) as? CharactersListCell else {
            return UITableViewCell()
        }
        
        cell.set(with: characters[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}

// MARK: - CharactersListPresenterDelegate

extension CharactersListViewController: CharactersListPresenterDelegate {
    func reloadData() {
        characters = self.presenter.characters
        messageLabel.isHidden = true
        tableView.reloadData()
    }
    
    func show(message: String) {
        messageLabel.text = message
        messageLabel.isHidden = false
    }
    
    func showLoading() {
        showSpinner()
    }
    
    func hideLoading() {
        hideSpinner()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ACEPTAR", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - SearchBar Delegate

extension CharactersListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            characters.removeAll()
            tableView.reloadData()
            presenter.search(text: text)
        }
    }
}

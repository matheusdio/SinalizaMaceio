//
//  FirstViewController.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 30/06/24.
//

import UIKit

class FirstViewController: UIViewController {
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        label.textColor = .white
        label.text = "Bem vindo!"
        
        return label
    }()
    
    lazy var searchButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: ""), for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            searchBar.placeholder = "Pesquisar"
            return searchBar
        }()
    
    @objc func searchButtonTapped() {
            
            print("Botão de pesquisa foi tocado!")
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setConstraints()
        
    }
    
    func setHierarchy() {
        
        view.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(searchButton)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
        
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 40),
            
            searchButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50),
        ])
    }

}

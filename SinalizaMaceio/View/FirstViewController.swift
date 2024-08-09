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
        view.backgroundColor = #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.font = UIFont.boldSystemFont(ofSize: 28)
            label.textColor = .darkGray
            label.text = "Bem vindo à\nMaceió"
            
            return label
        }()
    
    
    lazy var bodyLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.text = "Maceió, com suas praias deslumbrantes, está se preparando para prosperar e se transformar através da tecnologia."
        
        return label
    }()
    
    lazy var startButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Start", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 27
            button.clipsToBounds = true
            addGradientToButton(button)
            return button
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        
            addGradientToButton(startButton)
        }
    
    private func addGradientToButton(_ button: UIButton) {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = button.bounds
            gradientLayer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.5, y: 1)
            
            button.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            
            button.layer.insertSublayer(gradientLayer, at: 0)
        }
    
    func setHierarchy() {
        
        view.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(bodyLabel)
        container.addSubview(startButton)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
        
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 40),
            
            bodyLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -130),
            bodyLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 40),
            bodyLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -80),
            bodyLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            startButton.topAnchor.constraint(equalTo: container.bottomAnchor, constant: -100),
            startButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50),
            startButton.widthAnchor.constraint(equalToConstant: 55),
            startButton.heightAnchor.constraint(equalToConstant: 55)
            
        ])
    }

}

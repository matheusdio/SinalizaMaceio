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
        view.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    lazy var firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "appbackground2")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textColor = .darkGray
        label.text = "Bem vindo à\nMaceió"
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .lightGray
        label.text = "Maceió, com suas praias deslumbrantes, está se preparando para prosperar e se transformar através da tecnologia."
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Iniciar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 59/2
        button.clipsToBounds = true
        addGradientToButton(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setConstraints()
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        let secondViewController = MapViewController()
        secondViewController.modalPresentationStyle = .fullScreen
        present(secondViewController, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addGradientToButton(startButton)
    }
    
    private func addGradientToButton(_ button: UIButton) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = [UIColor.darkGray.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        button.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        button.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setHierarchy() {
        view.addSubview(container)
        container.addSubview(firstImageView)
        container.addSubview(titleLabel)
        container.addSubview(bodyLabel)
        container.addSubview(startButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            firstImageView.topAnchor.constraint(equalTo: container.topAnchor),
            firstImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            firstImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            firstImageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5),
            
            titleLabel.topAnchor.constraint(equalTo: firstImageView.bottomAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -60),
            bodyLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            startButton.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 30),
            startButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            startButton.widthAnchor.constraint(equalToConstant: 64),
            startButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}

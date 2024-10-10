//
//  SetupCollectionViewCell.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 25/10/24.
//

import UIKit

class SetupCollectionViewCell: UICollectionViewCell {
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 44
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 3
        return view
    }()
    
    lazy var imageViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var setupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var setupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Olá,"
        return label
    }()
    
    
    func setupLayout() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        contentView.addSubview(container)
        container.addSubview(imageViewContainer)
        container.addSubview(setupLabel)
        imageViewContainer.addSubview(setupImageView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            imageViewContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 30),
            imageViewContainer.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageViewContainer.widthAnchor.constraint(equalToConstant: 40),
            imageViewContainer.heightAnchor.constraint(equalToConstant: 40),
            
            setupLabel.topAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: 20),
            setupLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            setupLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            setupImageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor, constant: 10),
            setupImageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor, constant: 10),
            setupImageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: -10),
            setupImageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: -10),
        ])
    }
    
}

//
//  StartCollectionViewCell.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 25/10/24.
//

import UIKit

class StartCollectionViewCell: UICollectionViewCell {
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0.5, height: 1.5)
        view.layer.shadowRadius = 4
        return view
    }()
    
    lazy var startImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var startLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Olá,"
        label.textAlignment = .left
        return label
    }()
    
    func setupStartLayout() {
        
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        
        contentView.addSubview(container)
        container.addSubview(startImageView)
        container.addSubview(startLabel)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            startImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            startImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            startImageView.heightAnchor.constraint(equalToConstant: 50),
            startImageView.widthAnchor.constraint(equalToConstant: 50),
            
            startLabel.topAnchor.constraint(equalTo: startImageView.bottomAnchor, constant: 20),
            startLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20)
        ])
    }
}

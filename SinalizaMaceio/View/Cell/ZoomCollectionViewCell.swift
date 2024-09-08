//
//  ZoomCollectionViewCell.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 04/09/24.
//

import UIKit

class ZoomCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ZoomCell"

    
    private let gradientLayer = CAGradientLayer()
    
    private let zoomLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        contentView.addSubview(zoomLabel)
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.isUserInteractionEnabled = true

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            zoomLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            zoomLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            zoomLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            zoomLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    private func setupGradientLayer() {
        gradientLayer.colors = [UIColor.darkGray.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.3, y: 1)
        gradientLayer.frame = contentView.bounds
        contentView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func configure(for index: Int) {
        let zoomLevels = ["Cidade", "Bairros", "Ruas"]
        zoomLabel.text = zoomLevels[index]
    }
}



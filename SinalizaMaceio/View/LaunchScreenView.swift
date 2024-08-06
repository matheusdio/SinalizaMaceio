//
//  LaunchScreenView.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 30/06/24.
//

import UIKit

class LaunchScreenView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "inaliza Maceió"
        label.font = UIFont(name: "Helvetica Neue", size: 36)
        label.textColor = .white
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        return label
    }()
    
    lazy var sinalizaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Spista") // Certifique-se de ter uma imagem chamada "Spista" no seu projeto
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setHierarchy()
        setConstraints()
        
        titleLabel.alpha = 0.0
        UIView.animate(withDuration: 2.0) {
            self.titleLabel.alpha = 1.0
        }
        
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { timer in
            self.transitionToNextView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.darkGray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setHierarchy() {
        addSubview(titleLabel)
        addSubview(sinalizaImageView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 365),
            titleLabel.leadingAnchor.constraint(equalTo: sinalizaImageView.trailingAnchor, constant: -10),
            
            sinalizaImageView.topAnchor.constraint(equalTo: topAnchor, constant: 325),
            sinalizaImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            sinalizaImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func transitionToNextView() {
        let mainViewController = FirstViewController()
        
        UIApplication.shared.windows.first?.rootViewController = mainViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

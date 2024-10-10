import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 3
        return view
    }()
    
    lazy var streetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Street"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.darkText
        return label
    }()
    
    lazy var neighborhoodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Neighborhood"
        label.textAlignment = .left
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Condition"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemBlue
        return label
    }()
    
    lazy var lastMaintenanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Last Maintenance"
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    lazy var optionsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mbcLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setupLayout() {
        setHierarchy()
        setConstraints()
    }
    
    func toggleLastMaintenanceVisibility(_ isVisible: Bool) {
        lastMaintenanceLabel.isHidden = !isVisible
    }
    
    private func setHierarchy() {
        contentView.addSubview(container)
        container.addSubview(streetLabel)
        container.addSubview(neighborhoodLabel)
        container.addSubview(conditionLabel)
        container.addSubview(lastMaintenanceLabel)
        container.addSubview(optionsImageView)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            optionsImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            optionsImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            optionsImageView.heightAnchor.constraint(equalToConstant: 50),
            optionsImageView.widthAnchor.constraint(equalToConstant: 50),
            
            streetLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            streetLabel.leadingAnchor.constraint(equalTo: optionsImageView.trailingAnchor, constant: 15),
            streetLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            neighborhoodLabel.topAnchor.constraint(equalTo: streetLabel.bottomAnchor, constant: 5),
            neighborhoodLabel.leadingAnchor.constraint(equalTo: optionsImageView.trailingAnchor, constant: 15),
            neighborhoodLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            conditionLabel.topAnchor.constraint(equalTo: neighborhoodLabel.bottomAnchor, constant: 10),
            conditionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            conditionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            lastMaintenanceLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 5),
            lastMaintenanceLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            lastMaintenanceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
        ])
    }
}

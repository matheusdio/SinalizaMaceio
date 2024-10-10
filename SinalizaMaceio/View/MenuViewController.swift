//
//  MenuViewController.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 24/10/24.
//

import UIKit

class MenuViewController: UIViewController {
    
    var setupList: [Setup] = []
    var startList: [Start] = []
    
    private lazy var container: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        
        return view
    }()
    
    private lazy var topView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.layer.cornerRadius = 54
       
        return view
    }()
    
    private lazy var middleView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9985123277, green: 0.9146969318, blue: 0.811891377, alpha: 1)
        view.layer.cornerRadius = 54
        
        return view
    }()
    
    private lazy var bottomView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 54
        
        return view
    }()
    
    private lazy var auxView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9985123277, green: 0.9146969318, blue: 0.811891377, alpha: 1)
        view.layer.cornerRadius = 0
        
        return view
    }()
    
    lazy var firstTitleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        label.text = "Olá,"
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .darkGray
        label.text = "Vamos encontrar a\nmelhor rota pra você!"
        
        return label
    }()
    
    lazy var setupLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        label.text = "Ajustes"
        
        return label
    }()
    
    lazy var startLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        label.text = "Vamos começar!"
        
        return label
    }()
    
    lazy var firstImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "sinalizaMark")
        
        return imageView
    }()
    
    private lazy var setupCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SetupCollectionViewCell.self, forCellWithReuseIdentifier: "SetupCollectionViewCell")
        return collectionView
    }()
    
    private lazy var startCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StartCollectionViewCell.self, forCellWithReuseIdentifier: "StartCollectionViewCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createStartButton()
        createNewSetup()
        setHierarchy()
        setConstraints()
    }
    
    func createNewSetup() {
        
        let setup1: Setup = Setup(title: "Equipe", image: UIImage(named: "teamicon"))
        let setup2: Setup = Setup(title: "Ferramentas", image: UIImage(named: "toolsicon"))
        
        setupList.append(setup1)
        setupList.append(setup2)
    }
    
    func createStartButton() {
        
        let start1: Start = Start(title: "Ir\nPara o mapa", image: UIImage(named: "sinalizaMark"), color: #colorLiteral(red: 0.9985123277, green: 0.9146969318, blue: 0.811891377, alpha: 1))
        let start2: Start = Start(title: "Ir\nPara o tutorial", image: UIImage(named: "sinalizaMark"), color: #colorLiteral(red: 0.9695059657, green: 0.964541018, blue: 0.9990164638, alpha: 1))
        
        startList.append(start1)
        startList.append(start2)
    }
    
    func setHierarchy() {
        view.addSubview(container)
        container.addSubview(topView)
        container.addSubview(middleView)
        container.addSubview(auxView)
        container.addSubview(bottomView)
        middleView.addSubview(titleLabel)
        middleView.addSubview(firstTitleLabel)
        middleView.addSubview(firstImageView)
        bottomView.addSubview(setupLabel)
        bottomView.addSubview(startLabel)
        bottomView.addSubview(setupCollectionView)
        bottomView.addSubview(startCollectionView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            topView.topAnchor.constraint(equalTo: container.topAnchor),
            topView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 250),
            
            middleView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 150),
            middleView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            middleView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -70),
            middleView.heightAnchor.constraint(equalToConstant: 200),
            
            auxView.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: -30),
            auxView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            auxView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -100),
            auxView.heightAnchor.constraint(equalToConstant: 90),
            
            bottomView.topAnchor.constraint(equalTo: auxView.bottomAnchor, constant: -65),
            bottomView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 2),
            bottomView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            firstImageView.topAnchor.constraint(equalTo: middleView.topAnchor, constant: 10),
            firstImageView.trailingAnchor.constraint(equalTo: middleView.trailingAnchor, constant: -25),
            firstImageView.heightAnchor.constraint(equalToConstant: 70),
            firstImageView.widthAnchor.constraint(equalToConstant: 70),
            
            firstTitleLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            firstTitleLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 25),
            
            titleLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 25),
            titleLabel.bottomAnchor.constraint(equalTo: middleView.bottomAnchor, constant: -40),
            
            setupLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 40),
            setupLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25),
            
            setupCollectionView.topAnchor.constraint(equalTo: setupLabel.bottomAnchor, constant: 10),
            setupCollectionView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25),
            setupCollectionView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            setupCollectionView.heightAnchor.constraint(equalToConstant: 140),
            
            startLabel.topAnchor.constraint(equalTo: setupCollectionView.bottomAnchor, constant: 30),
            startLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25),
            
            startCollectionView.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 10),
            startCollectionView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25),
            startCollectionView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            startCollectionView.heightAnchor.constraint(equalToConstant: 230)
            
        ])
    }

}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == setupCollectionView {
            return setupList.count
        } else if collectionView == startCollectionView {
            return startList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == setupCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SetupCollectionViewCell", for: indexPath) as! SetupCollectionViewCell
            cell.setupLayout()
            
            cell.setupLabel.text = setupList[indexPath.item].title
            cell.setupImageView.image = setupList[indexPath.item].image
            cell.setupLabel.textColor = UIColor.darkGray
            cell.container.backgroundColor = #colorLiteral(red: 0.9695060849, green: 0.9645408988, blue: 0.9947254062, alpha: 1)
            
            return cell
        } else if collectionView == startCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StartCollectionViewCell", for: indexPath) as! StartCollectionViewCell
            cell.setupStartLayout()
            
            cell.startLabel.text = startList[indexPath.item].title
            cell.startImageView.image = startList[indexPath.item].image
            cell.startLabel.textColor = UIColor.darkGray
            cell.container.backgroundColor = startList[indexPath.item].color
            
            return cell
        }
        
        return UICollectionViewCell()
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == setupCollectionView {
            return CGSize(width: 105, height: 155)
        } else if collectionView == startCollectionView {
            return CGSize(width: 165, height: 190)
        }
        return CGSize(width: 105, height: 155)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        if let cell = collectionView.cellForItem(at: indexPath) as? SetupCollectionViewCell {
            cell.setupLabel.textColor = UIColor.white
            cell.container.backgroundColor = UIColor.gray
        }
        
        if collectionView == startCollectionView {
            if indexPath.item == 0 {
                let mapViewController = MapViewController()
                    mapViewController.modalPresentationStyle = .fullScreen
                    present(mapViewController, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SetupCollectionViewCell {
            cell.setupLabel.textColor = UIColor.darkGray
            cell.container.backgroundColor = #colorLiteral(red: 0.9695060849, green: 0.9645408988, blue: 0.9947254062, alpha: 1)
        }
        
    }
}

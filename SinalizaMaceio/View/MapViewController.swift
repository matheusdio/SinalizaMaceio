//
//  MapViewController.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 09/08/24.
//

import UIKit
import TomTomSDKMapDisplay
import TomTomSDKNavigation
import CoreLocation
import TomTomSDKCommon
import TomTomSDKReverseGeocoder
import TomTomSDKReverseGeocoderOnline
import TomTomSDKNavigationEngines
import TomTomSDKRoute
import TomTomSDKSearch
import TomTomSDKSearchOnline

class MapViewController: UIViewController {

    var cardList: [Card] = []
    var selectedCardList: Card?
    let onlineSearch = OnlineSearchFactory.create(apiKey: "jZjWA6XkfKqKmGwn4hLhPWcUjsBnTWBG")
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    private lazy var cardView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: 1)
        view.layer.cornerRadius = 24
        
        return view
    }()
    
    private lazy var mapView: MapView = {
        
        let mapOptions = MapOptions(mapStyle: .defaultStyle, apiKey: "jZjWA6XkfKqKmGwn4hLhPWcUjsBnTWBG")
        let mapView = MapView(mapOptions: mapOptions)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        return mapView
    }()
    
    private lazy var mapZoomCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ZoomCollectionViewCell.self, forCellWithReuseIdentifier: ZoomCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    private lazy var cardCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCollectionViewCell")
        
        return collectionView
    }()
    
    lazy var viewButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Visualizar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        addGradientToButton(button)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        setupConstraints()
        mapView.onMapReadyCallback = { [weak self] map in
            self?.setInitialCameraPosition(map: map)
        }
        mapZoomCollectionView.isUserInteractionEnabled = true
        view.layoutIfNeeded()
        addGradientToButton(viewButton)
        createNewCard()
        cardCollectionView.reloadData()
    }
    
    private func setInitialCameraPosition(map: TomTomMap) {
        let centerCoordinate = CLLocationCoordinate2D(latitude: -9.66599, longitude: -35.73528)
        let zoomLevel = 12.0
        let cameraUpdate = CameraUpdate(position: centerCoordinate, zoom: zoomLevel)
        map.moveCamera(cameraUpdate)
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
    
    func createNewCard() {
        
        let card1: Card = Card(street: "Menino Marcelo", neighborhood: "Serraria", condition: "Bom Estado", lastMaintenance: "13/09/2024", conditionImage: UIImage(named: "bomestado"))
        let card2: Card = Card(street: "Fernandes Lima", neighborhood: "Farol", condition: "Parcialmente Desgastada", lastMaintenance: "12/06/2024", conditionImage: UIImage(named: "mauestado"))
        let card3: Card = Card(street: "Alvaro Otacilio", neighborhood: "Ponta Verde", condition: "Bom estado", lastMaintenance: "20/08/2024", conditionImage: UIImage(named: "mauestado"))
        
        cardList.append(card1)
        cardList.append(card2)
        cardList.append(card3)
    }
    
    private func setupViewHierarchy() {
        
        view.addSubview(container)
        container.addSubview(mapView)
        view.addSubview(mapZoomCollectionView)
        view.addSubview(cardView)
        view.addSubview(cardCollectionView)
        view.addSubview(viewButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mapView.topAnchor.constraint(equalTo: container.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            mapZoomCollectionView.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 60),
            mapZoomCollectionView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 97),
            mapZoomCollectionView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -97),
            mapZoomCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            cardView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 280),
            
            viewButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30),
            viewButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 40),
            viewButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -40),
            viewButton.heightAnchor.constraint(equalToConstant: 50),
            
            cardCollectionView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            cardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            cardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mapZoomCollectionView {
            
            return 3
        } else if collectionView == cardCollectionView {
            
            return cardList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mapZoomCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZoomCollectionViewCell.reuseIdentifier, for: indexPath) as! ZoomCollectionViewCell
            cell.configure(for: indexPath.row)
            
            return cell
            
        } else if collectionView == cardCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
            
            cell.setupLayout()
            cell.container.backgroundColor = UIColor.lightGray
            cell.streetLabel.text = cardList[indexPath.item].street
            cell.neighborhoodLabel.text = cardList[indexPath.item].neighborhood
            cell.conditionLabel.text = cardList[indexPath.item].condition
            cell.lastMaintenanceLabel.text = cardList[indexPath.item].lastMaintenance
            cell.optionsImageView.image = cardList[indexPath.item].conditionImage
            cell.container.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == mapZoomCollectionView {
            return CGSize(width: 60, height: 25)
            
        } else if collectionView == cardCollectionView {
            return CGSize(width: 270, height: 140)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mapZoomCollectionView {
           
            let zoomLevels: [Double] = [12, 13, 17]
            let zoomLevel = zoomLevels[indexPath.row]
            
            mapView.getMapAsync { map in
                let position = CLLocationCoordinate2D(latitude: -9.66599, longitude: -35.73528)
                let cameraUpdate = CameraUpdate(position: position, zoom: zoomLevel)
                let animationDuration: TimeInterval = 0.4
                
                map.applyCamera(cameraUpdate, animationDuration: animationDuration) { success in
                    if success {
                        print("Animação concluída com sucesso!")
                    } else {
                        print("Falha na animação.")
                    }
                }
            }
        } else if collectionView == cardCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
            let isCurrentlyVisible = !cell.lastMaintenanceLabel.isHidden
            
            cell.toggleLastMaintenanceVisibility(!isCurrentlyVisible)
        }
    }
}

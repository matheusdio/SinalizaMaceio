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

class MapViewController: UIViewController {

    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    private lazy var cardView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        setupConstraints()
        mapView.onMapReadyCallback = { [weak self] map in
            self?.setInitialCameraPosition(map: map)
        }
        mapZoomCollectionView.isUserInteractionEnabled = true
        view.layoutIfNeeded()
    }
    
    private func setInitialCameraPosition(map: TomTomMap) {
        let centerCoordinate = CLLocationCoordinate2D(latitude: -9.66599, longitude: -35.73528)
        let zoomLevel = 12.0
        let cameraUpdate = CameraUpdate(position: centerCoordinate, zoom: zoomLevel)
        map.moveCamera(cameraUpdate)
    }
    
    
    private func setupViewHierarchy() {
        view.addSubview(container)
        container.addSubview(mapView)
        view.addSubview(mapZoomCollectionView)
        view.addSubview(cardView)

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
            cardView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZoomCollectionViewCell.reuseIdentifier, for: indexPath) as! ZoomCollectionViewCell
        cell.configure(for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
    }
}



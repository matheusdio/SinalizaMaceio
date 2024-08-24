//
//  MapViewController.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 09/08/24.
//

import UIKit
import TomTomSDKMapDisplay
import TomTomSDKNavigation

class MapViewController: UIViewController {
    
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    lazy var mapView: MapView = {
      let mapOptions = MapOptions(mapStyle: .defaultStyle, apiKey: "jZjWA6XkfKqKmGwn4hLhPWcUjsBnTWBG")
      let mapView = MapView(mapOptions: mapOptions)
        mapView.translatesAutoresizingMaskIntoConstraints = false
      return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setConstraints()
        mapView.cameraUpdate = .init(position: .init(latitude: -9.66599, longitude: -35.73528), zoom: 12)
    }
    
    func setHierarchy() {
        
        view.addSubview(container)
        container.addSubview(mapView)
    }
    
    func setConstraints() {
     
        NSLayoutConstraint.activate([
        
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mapView.topAnchor.constraint(equalTo: container.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }


}

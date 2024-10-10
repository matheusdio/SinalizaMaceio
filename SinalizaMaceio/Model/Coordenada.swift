//
//  Coordenada.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 29/05/25.
//


import CoreLocation

struct Coordenada: Hashable {
    let latitude: Double
    let longitude: Double
    
    init(_ coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
}

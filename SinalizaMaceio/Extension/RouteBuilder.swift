//
//  RouteBuilder.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 30/05/25.
//


import Foundation
import MapKit

class RouteBuilder {

    private(set) var vertices: [CLLocationCoordinate2D] = []
    private var adjacencias: [[Int]] = []
    private let maxDistanciaPermitida: Double = 800

    func buildGraph(from vertices: [CLLocationCoordinate2D]) {
        self.vertices = vertices
        adjacencias = Array(repeating: [], count: vertices.count)

        for i in 0..<vertices.count {
            for j in 0..<vertices.count {
                if i != j {
                    let dist = CLLocation(latitude: vertices[i].latitude, longitude: vertices[i].longitude)
                        .distance(from: CLLocation(latitude: vertices[j].latitude, longitude: vertices[j].longitude))
                    if dist < maxDistanciaPermitida {
                        adjacencias[i].append(j)
                    }
                }
            }
        }
    }

    func generateOptimalRoute(limitTo count: Int = Int.max) -> [CLLocationCoordinate2D] {
        return Array(vertices.prefix(count))
    }


    func drawRoute(on mapView: MKMapView) {
        let polyline = MKPolyline(coordinates: vertices, count: vertices.count)
        mapView.addOverlay(polyline)
    }
}

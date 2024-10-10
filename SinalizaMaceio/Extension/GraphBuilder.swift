//
//  GraphBuilder.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 30/05/25.
//


import Foundation
import MapKit

class GraphBuilder {
    func buildGraph(from features: [MKGeoJSONFeature]) -> [CLLocationCoordinate2D: [CLLocationCoordinate2D]] {
        var grafo: [CLLocationCoordinate2D: [CLLocationCoordinate2D]] = [:]

        for feature in features {
            guard let polyline = feature.geometry.first as? MKPolyline else { continue }

            let coords = polyline.coordinates()

            for i in 0..<coords.count - 1 {
                let from = coords[i]
                let to = coords[i + 1]

                grafo[from, default: []].append(to)
                grafo[to, default: []].append(from)
            }
        }

        return grafo
    }
}

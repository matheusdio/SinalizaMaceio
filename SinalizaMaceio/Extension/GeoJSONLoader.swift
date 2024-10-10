//
//  GeoJSONLoader.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 30/05/25.
//


import Foundation
import MapKit

class GeoJSONLoader {
    var graph: [CLLocationCoordinate2D: [CLLocationCoordinate2D]] = [:]

    func loadGeoJSON(from fileName: String, completion: @escaping ([MKGeoJSONFeature]) -> Void) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "geojson") else {
            print("Arquivo GeoJSON não encontrado.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = MKGeoJSONDecoder()
            let geoJSON = try decoder.decode(data)
            let features = geoJSON.compactMap { $0 as? MKGeoJSONFeature }
            completion(features)
        } catch {
            print("Erro ao carregar o GeoJSON: \(error)")
        }
    }


    func buildGraph(from features: [MKGeoJSONFeature]) {
        var grafo: [CLLocationCoordinate2D: [CLLocationCoordinate2D]] = [:]

        let allowedHighwayTypes: Set<String> = [
            "motorway", "trunk", "primary", "secondary", "tertiary",
            "residential", "unclassified", "service", "living_street"
        ]

        for feature in features {
            guard
                let propertiesData = feature.properties,
                let json = try? JSONSerialization.jsonObject(with: propertiesData) as? [String: Any],
                let highway = json["highway"] as? String,
                allowedHighwayTypes.contains(highway)
            else {
                continue
            }

            for geometry in feature.geometry {
                guard let polyline = geometry as? MKPolyline else { continue }

                let coords = polyline.coordinates()
                for i in 0..<coords.count - 1 {
                    let from = coords[i]
                    let to = coords[i + 1]

                    grafo[from, default: []].append(to)
                    grafo[to, default: []].append(from)
                }
            }
        }

        self.graph = grafo
    }

}


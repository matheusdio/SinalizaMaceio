//
//  Grafo.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 28/05/25.
//

import UIKit
import MapKit

import MapKit

struct Grafo {
    var adjacencias: [CLLocationCoordinate2D: [CLLocationCoordinate2D]] = [:]

    mutating func adicionarAresta(inicio: CLLocationCoordinate2D, fim: CLLocationCoordinate2D) {
        adjacencias[inicio, default: []].append(fim)
        adjacencias[fim, default: []].append(inicio)
    }

    func grauDoVertice(_ vertice: CLLocationCoordinate2D) -> Int {
        return adjacencias[vertice]?.count ?? 0
    }
}


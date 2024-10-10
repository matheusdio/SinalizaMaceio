//
//  MKPolyline.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 28/05/25.
//

import MapKit

extension MKPolyline {
    func coordinates() -> [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: self.pointCount)
        self.getCoordinates(&coords, range: NSRange(location: 0, length: self.pointCount))
        return coords
    }
}

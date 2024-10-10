//
//  AnimationController.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 30/05/25.
//


import UIKit
import MapKit

class AnimationController {

    private weak var mapView: MKMapView?
    private let coordinates: [CLLocationCoordinate2D]
    private var index = 0
    private var timer: Timer?

    init(mapView: MKMapView, coordinates: [CLLocationCoordinate2D]) {
        self.mapView = mapView
        self.coordinates = coordinates
    }

    func startAnnotationAnimation(animatedPoint: MKPointAnnotation) {
        guard !coordinates.isEmpty else { return }

        animatedPoint.coordinate = coordinates[0]
        mapView?.addAnnotation(animatedPoint)

        index = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            guard self.index < self.coordinates.count else {
                self.timer?.invalidate()
                return
            }

            UIView.animate(withDuration: 0.03) {
                animatedPoint.coordinate = self.coordinates[self.index]
            }
            self.index += 1
        }
    }

    func addParticleAnimation() {
        guard let mapView = mapView else { return }

        let particleView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        particleView.backgroundColor = .red
        particleView.layer.cornerRadius = 14
        particleView.layer.borderColor = UIColor.white.cgColor
        particleView.layer.borderWidth = 3
        particleView.layer.shadowColor = UIColor.yellow.cgColor
        particleView.layer.shadowRadius = 14
        particleView.layer.shadowOpacity = 1.0
        particleView.layer.shadowOffset = .zero

        mapView.addSubview(particleView)

        let path = UIBezierPath()
        for (i, coord) in coordinates.enumerated() {
            let point = mapView.convert(coord, toPointTo: mapView)
            i == 0 ? path.move(to: point) : path.addLine(to: point)
        }

        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = 6.0
        animation.repeatCount = .infinity
        animation.calculationMode = .paced
        animation.rotationMode = .rotateAuto
        particleView.layer.add(animation, forKey: "moveAlongPath")
    }
}

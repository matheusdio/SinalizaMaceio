//
//  MapViewController.swift
//  SinalizaMaceio
//
//  Created by Matheus Dionísio on 09/08/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    let mapView = MKMapView()
    var timer: Timer?
    var animatedPolyline: MKPolyline?
    var routeCoordinates: [CLLocationCoordinate2D] = []
    var currentIndex = 0
    var botaoAdicionarMarcador: UIButton!
    var botaoFeedbackPonto: UIButton!
    var botaoFiltrarRota: UIButton!
    var selectedPoint: CLLocationCoordinate2D?
    var selectedAnnotationView: MKMarkerAnnotationView?
    var stateButtons: [UIButton] = []
    var stateLabels:  [UILabel]  = []
    var feedbackChatView: UIView?

    
    let stateButtonSize: CGFloat       = 40
    let stateDistHorizontal: CGFloat   = 80
    let stateDistVertical: CGFloat     = 80
    let stateExtraHorizYellow: CGFloat = 20
    let stateLabelOffset: CGFloat      = 4
    let stateAngles: [CGFloat]         = [ .pi, -CGFloat.pi/2, 0 ]
    let stateTitles  = ["Ótima", "Desgastada", "Muito desgastada"]
    let stateColors: [UIColor]         = [.green, .yellow, .red]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.frame = view.bounds
        view.addSubview(mapView)
        mapView.delegate = self
        configurarBotoesInferiores()
        adicionarGestos()

        let initialLocation = CLLocationCoordinate2D(latitude: -9.649849, longitude: -35.708949)
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)

        adicionarBotoesZoom()
        
        let origem = CLLocationCoordinate2D(latitude: -9.649849, longitude: -35.708949)
        let destino = CLLocationCoordinate2D(latitude: -9.655478, longitude: -35.737022)
        
        criarRota(origem: origem, destino: destino)
    }
    

    func configurarBotoesInferiores() {
        let tamanhoBotao: CGFloat = 60
        let bottomMargin: CGFloat = 100
        let spacingX: CGFloat = 100
        let midX = view.frame.midX
        let yPos = view.frame.height - bottomMargin

        botaoAdicionarMarcador = UIButton(frame: CGRect(
            x: midX - spacingX - tamanhoBotao/2,
            y: yPos,
            width: tamanhoBotao,
            height: tamanhoBotao))
        botaoAdicionarMarcador.setTitle("📍", for: .normal)
        botaoAdicionarMarcador.backgroundColor = .white
        botaoAdicionarMarcador.layer.cornerRadius = tamanhoBotao / 2
        botaoAdicionarMarcador.addTarget(self, action: #selector(adicionarMarcador), for: .touchUpInside)
        
        botaoFeedbackPonto = UIButton(frame: CGRect(
            x: midX - tamanhoBotao/2,
            y: yPos,
            width: tamanhoBotao,
            height: tamanhoBotao))
        botaoFeedbackPonto.setTitle("💬", for: .normal)
        botaoFeedbackPonto.backgroundColor = .white
        botaoFeedbackPonto.layer.cornerRadius = tamanhoBotao / 2
        botaoFeedbackPonto.addTarget(self, action: #selector(receberFeedbackPonto), for: .touchUpInside)

        botaoFiltrarRota = UIButton(frame: CGRect(
            x: midX + spacingX - tamanhoBotao/2,
            y: yPos,
            width: tamanhoBotao,
            height: tamanhoBotao))
        botaoFiltrarRota.setTitle("⚙️", for: .normal)
        botaoFiltrarRota.backgroundColor = .white
        botaoFiltrarRota.layer.cornerRadius = tamanhoBotao / 2
        botaoFiltrarRota.addTarget(self, action: #selector(filtrarRota), for: .touchUpInside)

        view.addSubview(botaoAdicionarMarcador)
        view.addSubview(botaoFeedbackPonto)
        view.addSubview(botaoFiltrarRota)
        esconderBotoesInferiores()
    }

    
    func esconderBotoesInferiores() {
        botaoAdicionarMarcador.isHidden = true
        botaoFeedbackPonto.isHidden = true
        botaoFiltrarRota.isHidden = true
    }
    
    func mostrarBotoesInferiores() {
        botaoAdicionarMarcador.isHidden = false
        botaoFeedbackPonto.isHidden = false
        botaoFiltrarRota.isHidden = false
    }
    
    @objc func adicionarMarcador() {
        guard let coord = selectedPoint else { return }
        let localTouch = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
        
        // define um limiar de “mesmo ponto” (em metros)
        let distanciaMaximaParaMatch: CLLocationDistance = 10
        
        // procura um pin existente perto desse ponto
        if let existingPin = mapView.annotations
            .compactMap({ $0 as? MKPointAnnotation })
            .first(where: {
                let pinLoc = CLLocation(latitude: $0.coordinate.latitude,
                                        longitude: $0.coordinate.longitude)
                return pinLoc.distance(from: localTouch) < distanciaMaximaParaMatch
            })
        {

            mapView.removeAnnotation(existingPin)
        } else {
            
            let pin = MKPointAnnotation()
            pin.coordinate = coord
            mapView.addAnnotation(pin)
        }
        
        esconderBotoesInferiores()
    }


    @objc func receberFeedbackPonto() {
        print("Botão 'Feedback do Ponto' pressionado!")
    
    }

    @objc func filtrarRota() {
        print("Botão 'Filtrar Rota' pressionado!")
    }



    func criarRota(origem: CLLocationCoordinate2D, destino: CLLocationCoordinate2D) {
        let origemItem = MKMapItem(placemark: MKPlacemark(coordinate: origem))
        let destinoItem = MKMapItem(placemark: MKPlacemark(coordinate: destino))
        
        let request = MKDirections.Request()
        request.source = origemItem
        request.destination = destinoItem
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("Erro ao calcular rota: \(error.localizedDescription)")
                return
            }
            
            guard let rota = response?.routes.first else { return }
            let pointCount = rota.polyline.pointCount
            let pointsPointer = rota.polyline.points()

            self.routeCoordinates = (0..<pointCount).map { i in
                return pointsPointer[i].coordinate
            }

            
            self.startAnimatingRoute()
        }
    }
    
    func adicionarGestos() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(detectarToqueNoMapa(_:)))
        mapView.addGestureRecognizer(tap)
    }
    
    @objc func detectarToqueNoMapa(_ gesture: UITapGestureRecognizer) {
        hideFeedbackChat()

        let pontoView = gesture.location(in: mapView)
        let coordTouch = mapView.convert(pontoView, toCoordinateFrom: mapView)

        guard let nearest = encontrarPontoMaisProximo(toque: coordTouch),
              CLLocation(latitude: nearest.latitude, longitude: nearest.longitude)
                .distance(from: CLLocation(latitude: coordTouch.latitude,
                                           longitude: coordTouch.longitude)) < 30
        else {
            selectedPoint = nil
            esconderBotoesInferiores()
            return
        }

        selectedPoint = nearest
        mostrarBotoesInferiores()
    }



    
    func encontrarPontoMaisProximo(toque: CLLocationCoordinate2D) -> CLLocationCoordinate2D? {
        guard !routeCoordinates.isEmpty else { return nil }
        var closest: CLLocationCoordinate2D?
        var minDist = CLLocationDistance.greatestFiniteMagnitude

        for pt in routeCoordinates {
            let dist = CLLocation(latitude: pt.latitude, longitude: pt.longitude)
                     .distance(from: CLLocation(latitude: toque.latitude, longitude: toque.longitude))
            if dist < minDist {
                minDist = dist
                closest = pt
            }
        }
        return closest
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        guard let marker = selectedAnnotationView,
              !stateButtons.isEmpty else { return }

        let pinCenter = mapView.convert(marker.annotation!.coordinate,
                                        toPointTo: view)

        for i in 0..<stateButtons.count {
          let angle = stateAngles[i]
          let dist  = (i == 1 ? stateDistVertical : stateDistHorizontal)
          let extraX = (i == 1 ? stateExtraHorizYellow : 0)

          let xBtn = pinCenter.x + cos(angle)*dist + extraX
          let yBtn = pinCenter.y + sin(angle)*dist

          let btn = stateButtons[i]
          btn.center = CGPoint(x: xBtn, y: yBtn)

          let lbl = stateLabels[i]
          let labelAngle = angle - .pi/8
          let labelDist  = stateButtonSize/2 + lbl.bounds.height/2 + stateLabelOffset
          let xLbl = xBtn + cos(labelAngle)*labelDist
          let yLbl = yBtn + sin(labelAngle)*labelDist
          lbl.center = CGPoint(x: xLbl, y: yLbl)
        }
      }
    
    func showStateButtons(around marker: MKMarkerAnnotationView) {
      hideStateButtons()
      guard let coord = marker.annotation?.coordinate else { return }
      let pinCenter = mapView.convert(coord, toPointTo: view)

      for i in 0..<3 {
        let angle = stateAngles[i]
        let dist  = (i == 1 ? stateDistVertical : stateDistHorizontal)
        let extraX = (i == 1 ? stateExtraHorizYellow : 0)
        let xBtn = pinCenter.x + cos(angle)*dist + extraX
        let yBtn = pinCenter.y + sin(angle)*dist

        // botão
        let btn = UIButton(type: .system)
        btn.frame = CGRect(origin: .zero,
                           size: CGSize(width: stateButtonSize,
                                        height: stateButtonSize))
        btn.center = CGPoint(x: xBtn, y: yBtn)
        btn.backgroundColor   = stateColors[i]
        btn.layer.cornerRadius = stateButtonSize/2
        btn.layer.borderWidth  = 2
        btn.layer.borderColor  = UIColor.white.cgColor
        btn.tag = i
        btn.addTarget(self, action: #selector(stateButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(btn)
        stateButtons.append(btn)

        // label
        let lbl = UILabel()
        lbl.text          = stateTitles[i]
        lbl.font          = .systemFont(ofSize: 12, weight: .semibold)
        lbl.textColor     = .black
        lbl.backgroundColor   = .white
        lbl.layer.borderColor = UIColor.black.cgColor
        lbl.layer.borderWidth = 1
        lbl.layer.cornerRadius = 4
        lbl.clipsToBounds     = true
        lbl.textAlignment     = .center
        lbl.sizeToFit()
        lbl.frame.size.width  += 8
        lbl.frame.size.height += 4

        // coloca num “arco” ao redor do botão
        let labelAngle = angle - .pi/8
        let labelDist  = stateButtonSize/2 + lbl.bounds.height/2 + stateLabelOffset
        let xLbl = xBtn + cos(labelAngle)*labelDist
        let yLbl = yBtn + sin(labelAngle)*labelDist
        lbl.center = CGPoint(x: xLbl, y: yLbl)
        view.addSubview(lbl)
        stateLabels.append(lbl)
      }
    }

    func hideStateButtons() {
      stateButtons.forEach { $0.removeFromSuperview() }
      stateLabels .forEach { $0.removeFromSuperview() }
      stateButtons.removeAll()
      stateLabels .removeAll()
    }

    @objc func stateButtonTapped(_ sender: UIButton) {
      guard let marker = selectedAnnotationView else { return }
      marker.markerTintColor = stateColors[sender.tag]
      hideStateButtons()
      mapView.deselectAnnotation(marker.annotation, animated: false)
    }

    
    func showFeedbackChat() {
            // Se já estiver aberta, não faz nada
            guard feedbackChatView == nil else { return }

            // Tamanho da caixinha
            let chatWidth: CGFloat  = 200
            let chatHeight: CGFloat = 60
            // Offset vertical acima dos botões inferiores
            let bottomMargin: CGFloat = 100
            let gap: CGFloat          = 10
            // Calcula origem (centrado horizontalmente)
            let x = view.frame.midX - chatWidth/2
            let y = view.frame.height - bottomMargin - chatHeight - gap

            // 3.1) Container branco com borda preta
            let chat = UIView(frame: CGRect(x: x, y: y, width: chatWidth, height: chatHeight))
            chat.backgroundColor = .white
            chat.layer.cornerRadius  = 8
            chat.layer.borderWidth   = 1
            chat.layer.borderColor   = UIColor.black.cgColor

            // 3.2) Label com o texto
            let label = UILabel()
            label.text          = "Denuncie problemas"
            label.font          = UIFont.systemFont(ofSize: 14, weight: .semibold)
            label.textColor     = .black
            label.textAlignment = .center
            label.numberOfLines = 1
            // Ajusta frame da label dentro do chat
            label.frame = CGRect(x: 8,
                                 y: 8,
                                 width: chatWidth - 16,
                                 height: 20)
            chat.addSubview(label)

            // 3.3) Adiciona à view principal e guarda referência
            view.addSubview(chat)
            feedbackChatView = chat
        }

        // 4) Remove o chat da tela
        func hideFeedbackChat() {
            feedbackChatView?.removeFromSuperview()
            feedbackChatView = nil
        }
        

    func startAnimatingRoute() {
        timer?.invalidate()
        currentIndex = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if self.currentIndex < self.routeCoordinates.count {
                let partialRoute = Array(self.routeCoordinates.prefix(self.currentIndex))
                self.animatedPolyline = MKPolyline(coordinates: partialRoute, count: partialRoute.count)
                self.mapView.addOverlay(self.animatedPolyline!)
                self.currentIndex += 1
            } else {
                self.timer?.invalidate()
            }
        }
    }
    
    func adicionarBotoesZoom() {
        let buttonSize: CGFloat = 50
        let topMargin: CGFloat = 50
        
        let botaoZoomIn = UIButton(frame: CGRect(
            x: 20,
            y: topMargin,
            width: buttonSize,
            height: buttonSize))
        botaoZoomIn.setTitle("+", for: .normal)
        botaoZoomIn.backgroundColor = .white
        botaoZoomIn.layer.cornerRadius = buttonSize / 2
        botaoZoomIn.setTitleColor(.black, for: .normal)
        botaoZoomIn.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        
        let botaoZoomOut = UIButton(frame: CGRect(
            x: 20 + buttonSize + 10,
            y: topMargin,
            width: buttonSize,
            height: buttonSize))
        botaoZoomOut.setTitle("-", for: .normal)
        botaoZoomOut.backgroundColor = .white
        botaoZoomOut.layer.cornerRadius = buttonSize / 2
        botaoZoomOut.setTitleColor(.black, for: .normal)
        botaoZoomOut.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        
        view.addSubview(botaoZoomIn)
        view.addSubview(botaoZoomOut)
        
        // garante que fiquem sobre o mapa
        view.bringSubviewToFront(botaoZoomIn)
        view.bringSubviewToFront(botaoZoomOut)
    }



    @objc func zoomIn() {
        let region = mapView.region
        let zoomedRegion = MKCoordinateRegion(center: region.center,
                                              span: MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * 0.7,
                                                                     longitudeDelta: region.span.longitudeDelta * 0.7))
        mapView.setRegion(zoomedRegion, animated: true)
    }

    @objc func zoomOut() {
        let region = mapView.region
        let zoomedRegion = MKCoordinateRegion(center: region.center,
                                              span: MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * 1.3,
                                                                     longitudeDelta: region.span.longitudeDelta * 1.3))
        mapView.setRegion(zoomedRegion, animated: true)
    }

    
    // 2.1 — Quando o usuário tocar no pin
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let marker = view as? MKMarkerAnnotationView else { return }
        selectedAnnotationView = marker
        showStateButtons(around: marker)
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        hideStateButtons()
        selectedAnnotationView = nil
    }



    func mapView(_ mapView: MKMapView,
                     viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // ignore o “pino” de localização do usuário
            if annotation is MKUserLocation { return nil }

            let id = "colorPin"
            var marker = mapView.dequeueReusableAnnotationView(
                            withIdentifier: id) as? MKMarkerAnnotationView
            if marker == nil {
                marker = MKMarkerAnnotationView(
                            annotation: annotation,
                            reuseIdentifier: id)
                marker!.canShowCallout = false
                marker!.isDraggable   = false
            } else {
                marker!.annotation = annotation
            }
            // cor padrão antes de classificar
            marker!.markerTintColor = .gray
            return marker
        }

        // 3) Delegate para overlays (sua rota)
        func mapView(_ mapView: MKMapView,
                     rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            // desenha apenas MKPolyline
            if let linha = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(overlay: linha)
                renderer.strokeColor = .blue
                renderer.lineWidth   = 5
                return renderer
            }
            // para outros tipos de overlay, retorne um renderer genérico
            return MKOverlayRenderer(overlay: overlay)
        }
    }

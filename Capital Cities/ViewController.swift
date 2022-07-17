//
//  ViewController.swift
//  Capital Cities
//
//  Created by Camilo Hernández Guerrero on 16/07/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertController = UIAlertController(title: "Select a map type", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Standard", style: .default, handler: {
            [weak self] _ in
            self?.mapView.mapType = .standard
        }))
        alertController.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: {
            [weak self] _ in
            self?.mapView.mapType = .hybrid
        }))
        alertController.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: {
            [weak self] _ in
            self?.mapView.mapType = .hybridFlyover
        }))
        alertController.addAction(UIAlertAction(title: "Muted Standard", style: .default, handler: {
            [weak self] _ in
            self?.mapView.mapType = .mutedStandard
        }))
        alertController.addAction(UIAlertAction(title: "Satellite", style: .default, handler: {
            [weak self] _ in
            self?.mapView.mapType = .satellite
        }))
        alertController.addAction(UIAlertAction(title: "Satellite Flyover", style: .default, handler: {
            [weak self] _ in
            self?.mapView.mapType = .satelliteFlyover
        }))
        
        present(alertController, animated: true)
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.markerTintColor = .purple
            annotationView?.tintColor = .purple
            
            let btn = UIButton(type: .detailDisclosure, primaryAction: UIAction(handler: {
                [weak self] _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let webViewController = self?.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                        guard let country = annotation.title else { return }
                        webViewController.selectedCountry = country
                        self?.navigationController?.pushViewController(webViewController, animated: true)
                    }
                }
            }))
            
            annotationView?.rightCalloutAccessoryView = btn
            
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info

        let alertController = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alertController, animated: true)
    }
}

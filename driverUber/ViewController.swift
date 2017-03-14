//
//  ViewController.swift
//  driverUber
//
//  Created by IlanB on 14/03/2017.
//  Copyright © 2017 IlanB. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    private let _locationManager = CLLocationManager()
    
    @IBOutlet weak var isActivated: UISwitch!
    @IBOutlet weak var uiMap: MKMapView!
    @IBOutlet weak var viewDriverConstraint: NSLayoutConstraint!
    @IBOutlet weak var uiDriverName: UILabel!
    @IBOutlet weak var uiDriverCarName: UILabel!
    @IBOutlet weak var uiDriverCarImmat: UILabel!
    
    var annotations:[MKAnnotation]?
    
    var driver:Driver?
    
    let driverAnnotation = DriverMKPointAnnotation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        _locationManager.distanceFilter = 100
        
        uiMap.delegate = self
        
        self.driver = Driver(name: "Pepito", car: "Peugeot 3008", immat: "AB-123-XZ-92", status: 10)
        
        self.uiDriverName.text = self.driver!.getName()
        self.uiDriverCarName.text = self.driver!.getCar()
        self.uiDriverCarImmat.text = self.driver!.getImmat()
        
        self.driverAnnotation.title = "ok"
        self.uiMap.addAnnotation(self.driverAnnotation)
        
        viewDriverConstraint.constant -= view.bounds.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func activateLocation(_ sender: Any) {
        let authStatus:CLAuthorizationStatus = CLLocationManager.authorizationStatus()

        if isActivated.isOn {
            if authStatus == .denied || authStatus == .restricted {
                return
            }
            
            if authStatus == .notDetermined {
                _locationManager.requestAlwaysAuthorization()
                _locationManager.allowsBackgroundLocationUpdates = true
            }
            
            self.showDriverInfo()

            _locationManager.startUpdatingLocation()
            _locationManager.startUpdatingHeading()
            
            return
        }
        
        self.hideDriferInfo()
        
        self.driver?.removeLocations()

        _locationManager.stopUpdatingLocation()
        _locationManager.stopUpdatingHeading()
        
        return
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last,
            location.horizontalAccuracy < 101 {
            // Add last location to driver
            self.driver!.addLocation(location: location)
            
            let angle = self.angle(first: (self.driver!.getLastLocations()?.coordinate)!, second: (self.driver!.getLocationBeforeLast()?.coordinate)!)
            
            UIView.animate(withDuration: 6, delay: 0, options: [], animations: {
                self.driverAnnotation.coordinate = location.coordinate
                
                let anno = self.mapView(self.uiMap, viewFor: self.driverAnnotation)
                
                anno?.transform = CGAffineTransform(rotationAngle: angle)

            }, completion: nil)
            
            UIView.animate(withDuration: 8, delay: 0, options: [], animations: {
                self.uiMap.centerCoordinate = location.coordinate
                
                let reg = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
                
                self.uiMap.setRegion(reg, animated: false)
            }, completion: nil)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView?
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "iden") {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "iden")
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }

        annotationView?.image = UIImage(named: "uber_car")
        
        return annotationView
    }
    
    func angle(first: CLLocationCoordinate2D, second: CLLocationCoordinate2D) -> CGFloat {
        let deltaLongitude = second.longitude - first.longitude
        let deltaLatitude = second.latitude - first.latitude
        let angle = (M_PI * 0.5) - atan(deltaLatitude / deltaLongitude)
        
        if (deltaLongitude > 0) {
            return CGFloat(angle)
        }
        
        if (deltaLongitude < 0) {
            return CGFloat(angle) + CGFloat(M_PI)
        }
        
        if (deltaLatitude < 0) {
            return CGFloat(M_PI)
        }
        
        return 0.0
    }
    
    func showDriverInfo() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.viewDriverConstraint.constant += self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func hideDriferInfo() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.viewDriverConstraint.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

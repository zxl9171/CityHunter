//
//  ViewController.swift
//  CityHunter
//
//  Created by Xing Yichi on 10/23/15.
//  Copyright © 2015 xing. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBAction func testButton(sender: UIButton) {
        if userLocationManager.location == nil{
            testLabel.text = "nil"
        }else{
            let lc = userLocationManager.location!.coordinate
            testLabel.text = String(lc.longitude)
            
        }
    }
    @IBOutlet weak var testLabel: UILabel!
    
    // test data:
    let pd = PreyData()
    
    
    
    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.mapType = .Standard
            mapView.delegate = self
        }
    }
    
    var userLocationManager = CLLocationManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        userLocationManager.delegate = self
        userLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        //userLocationManager.distanceFilter = 1
        userLocationManager.requestWhenInUseAuthorization()
        userLocationManager.startUpdatingLocation()
        
        //print("the latitude is \(mapView.userLocation.location!.coordinate.latitude)");
        
        mapView.showsUserLocation = true
        
        
        pd.setPreyData()
        
        mapView.addAnnotation(pd)
    }

    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // you may delete this afterwards:
        userLocationManager.stopUpdatingLocation()
    }
    
    // MARK: MKMapViewDelegate functions
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        print("User Location Updated")
        var region = MKCoordinateRegion()
        var span = MKCoordinateSpan()
        
        // 1.5 is just a number for testing.
        span.latitudeDelta
            = (userLocation.coordinate.latitude > pd.coordinate.latitude) ?
            ( userLocation.coordinate.latitude - pd.coordinate.latitude) * (1.5) :
            ( pd.coordinate.latitude - userLocation.coordinate.latitude) * (1.5)
        
        span.longitudeDelta
            = (userLocation.coordinate.longitude > pd.coordinate.longitude) ?
            ( userLocation.coordinate.longitude - pd.coordinate.longitude) * (1.5) :
            ( pd.coordinate.longitude - userLocation.coordinate.longitude) * (1.5)
        
        let centerLocation
            = CLLocationCoordinate2D(
                latitude: (userLocation.coordinate.latitude + pd.coordinate.latitude) / 2
                , longitude: (userLocation.coordinate.longitude + pd.coordinate.longitude) / 2)
        
        
        region.span = span
        region.center = centerLocation
        
        mapView.setRegion(region, animated: true)
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier("preyAnnotationView")
        
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "preyAnnotationView")
            //view = MK
            view!.canShowCallout = true
            
        } else {
            view!.annotation = annotation
        }
        
        view!.leftCalloutAccessoryView = nil
        view!.rightCalloutAccessoryView = nil
        
        
        return view
    }
}

extension PreyData:MKAnnotation{
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: preyData[0].latitude, longitude: preyData[0].longitude)
    }
    var title: String?{
        return preyNameData[0]
    }
}



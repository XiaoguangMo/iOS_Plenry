//
//  EventArea.swift
//  Plenry
//
//  Created by NNNO on 7/29/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
//import CoreLocation

class EventArea: UIViewController, CLLocationManagerDelegate,GMSMapViewDelegate {
    var location:CLLocationCoordinate2D = CLLocationCoordinate2D()
    @IBOutlet var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.cameraWithLatitude(location.latitude,
            longitude:location.longitude, zoom:13)
        self.mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        self.mapView.delegate = self
        let myCircle = GMSCircle(position: location, radius: 500)
        myCircle.fillColor = ColorOpacityFourGreen
        myCircle.strokeColor = ColorOpacityTwoGreen
        myCircle.map = mapView
        mapView.myLocationEnabled = true
        self.view = mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

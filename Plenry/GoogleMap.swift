//
//  GoogleMap.swift
//  Plenry
//
//  Created by NNNO on 6/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import Alamofire
//import CoreLocation

class GoogleMap: UIViewController, CLLocationManagerDelegate,GMSMapViewDelegate {
    let locationManager = CLLocationManager()
    var didFindMyLocation = false
    @IBOutlet var mapView: GMSMapView!
    var searchController:UISearchController!
    var eventData:[EventData] = []
    var shouldwait = true
    var currentEvent = fakeData()
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) ->Void in
            if (error != nil) {
                print("Error:" + error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
//                let pm = placemarks[0] as! CLPlacemark
//                self.displayLocationInfo(pm)
            }else{
                print("Error with data")
            }
        })
    }
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        currentEvent = eventData[marker.userData as! Int]
        return false
    }
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
        print(placemark.locality)
        print(placemark.postalCode)
        print(placemark.administrativeArea)
        print(placemark.country)
    }
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            self.mapView.myLocationEnabled = true
        }else{
            self.mapView.myLocationEnabled = false
        }
    }
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        currentEvent = fakeData()
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location " + error.localizedDescription)
    }
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: EventDetail = storyboard.instantiateViewControllerWithIdentifier("EventDetail") as! EventDetail
        vc.currentEvent = currentEvent
        vc.operation = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        let subView = UIView(frame: CGRectMake(0, 0, 150, 150))
        let timeLabel = UILabel(frame: CGRectMake(7, 123, 140, 20))
        timeLabel.font = timeLabel.font.fontWithSize(9)
        timeLabel.text = getEventTime(eventData[marker.userData as! Int].time_startAt)
        let titleLabel = UILabel(frame: CGRectMake(5, 85, 140, 45))
        titleLabel.numberOfLines = 3
        titleLabel.text = eventData[marker.userData as! Int].theme
        titleLabel.textColor = ColorBrown
        titleLabel.font = titleLabel.font.fontWithSize(10)
        let imageView = UIImageView(frame: CGRectMake(0, 0, 150, 150))
        imageView.image = UIImage(named: "preview_on_map")
        let photo = UIImageView(frame: CGRectMake(0, 0, 150, 85))
        photo.image=getMapImage(eventData[marker.userData as! Int].image)
        subView.addSubview(imageView)
        subView.addSubview(titleLabel)
        subView.addSubview(timeLabel)
        subView.addSubview(photo)
        return subView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map View"
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        var camera = GMSCameraPosition()
        if self.mapView.myLocationEnabled {
            camera = GMSCameraPosition.cameraWithLatitude(locationManager.location!.coordinate.latitude,
                longitude:locationManager.location!.coordinate.longitude, zoom:10)
        }else{
            camera = GMSCameraPosition.cameraWithLatitude(CLLocationDegrees(37.8306030984809), longitude: CLLocationDegrees(-121.922752819955), zoom: 8)
        }
        self.mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        self.mapView.delegate = self
        if shouldwait {
            self.pleaseWait()
            shouldwait = !shouldwait
        }
        Alamofire.request(.GET, "http://plenry.com/rest/events/active")
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.eventData = explore_All(temp).sort(){$0.time_startAt < $1.time_startAt}
                    var markers:[GMSMarker] = [GMSMarker()]
                    for i in 0...self.eventData.count-1 {
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2DMake(Double(self.eventData[i].location_latApprox), Double(self.eventData[i].location_lngApprox))
                        marker.appearAnimation = kGMSMarkerAnimationPop
                        marker.userData = Int(i)
                        marker.tappable = true
                        marker.map = self.mapView
                        markers.append(marker)
                    }
                    self.view = self.mapView
                    self.clearAllNotice()
                }
        }
        self.view = self.mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showGoogleEvent" {
            let svc = segue.destinationViewController as! EventDetail
            svc.currentEvent = currentEvent
            svc.operation = 1
        }
    }
}

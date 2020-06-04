//
//  MapViewController.swift
//  TaipeiTravel
//
//  Created by mac25 on 2020/5/20.
//  Copyright © 2020 hsin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , CLLocationManagerDelegate,MKMapViewDelegate{

    let fullSize :CGSize = UIScreen.main.bounds.size
    let myUserDefaults :UserDefaults = UserDefaults.standard
    var fetchType :String = ""
    var info :[String:AnyObject]! = nil
    var latitude :Double = 0.0
    var longitude :Double = 0.0
    var myMapView :MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        latitude = info["latitude"] as? Double ?? 0.0
        longitude = info["longitude"] as? Double ?? 0.0
        
        self.title = info["title"] as? String ??  "標題"
        
        myMapView = MKMapView(frame: CGRect(x: 0, y: 00, width: fullSize.width, height: fullSize.height-113))
        
        myMapView.delegate = self
        myMapView.mapType = .standard
        myMapView.showsUserLocation = true
        myMapView.isZoomEnabled = true
        
        let latDelta = 0.005
        let longDelta = 0.005
        let currentLocationSpon:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        let center:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpon)
        myMapView.setRegion(currentRegion, animated: true)
        
        self.view.addSubview(myMapView)
        
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(latitude: latitude, longitude: longitude).coordinate
        objectAnnotation.title = self.title
        myMapView.addAnnotation(objectAnnotation)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

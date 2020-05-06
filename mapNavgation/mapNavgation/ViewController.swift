//
//  ViewController.swift
//  mapNavgation
//
//  Created by mac23 on 2020/5/6.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func onClick(_ sender: UIButton){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "郵局"
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start {
            (response, error) in
            guard error == nil else{
                return
            }
            guard response != nil else{
                return
            }
            for item in (response?.mapItems)!{
                self.mapView.addAnnotation(item.placemark)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

// 以下 導航不用map view 元件
//        let taipet101 = CLLocationCoordinate2D(latitude: 25.033850, longitude: 121.564977)
//        let airstation = CLLocationCoordinate2D(latitude: 25.068554, longitude: 121.552932)
//
//        let pA = MKPlacemark(coordinate: taipet101, addressDictionary: nil)
//        let pB = MKPlacemark(coordinate: airstation, addressDictionary: nil)
//
//        let miA = MKMapItem(placemark: pA)
//        let miB = MKMapItem(placemark: pB)
//        miA.name = "台北１０１"
//        miB.name = "松山機場"
//
//        let routes = [miA, miB]
//
//        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//
//        MKMapItem.openMaps(with: routes, launchOptions: options)
        
        
//        以下３Ｄmap 有加 map view 元件
//        let ground = CLLocationCoordinate2DMake(48.858356, 2.294481)
//
//        let eyeFrom = CLLocationCoordinate2DMake(48.847, 2.294481)
//
//        let camera = MKMapCamera(lookingAtCenter: ground, fromEyeCoordinate: eyeFrom, eyeAltitude: 50)
//        mapView.mapType = .satelliteFlyover
//        mapView.isPitchEnabled = true
//        mapView.camera = camera
//    }

        
//        以下是座標轉地址 可以不用map view元件
//        let location = CLLocation(latitude: 25.102645, longitude: 121.548506)
//        let geocoder = CLGeocoder()
//
//        geocoder.reverseGeocodeLocation(location) {
//            (placemarks, error) in
//            guard error == nil else{
//                return
//            }
//            guard placemarks != nil else{
//                return
//            }
//            for placemarks in placemarks!{
//                let addressDict = placemarks.addressDictionary
//                for key in (addressDict? .keys)!{
//                    let value = addressDict?[key]
//
//                    if value is NSArray{
//                        for p in value as! NSArray{
//                            print("=>\(key): \(p)")
//                        }
//                    }
//
//                    if value is String{
//                        print("=>\(key): \(value!)")
//                    }
//                }
//            }
//        }
        
        

    }
}


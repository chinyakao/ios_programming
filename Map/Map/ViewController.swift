//
//  ViewController.swift
//  Map
//
//  Created by mac23 on 2020/4/30.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
//    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mapView = view.subviews.first as? MKMapView
        let ann = MKPointAnnotation()
        ann.coordinate = CLLocationCoordinate2D(latitude: 24.137426, longitude: 121.275753)
//        ann.title = "NTUST"
//        ann.subtitle = "Taipei City"
        mapView?.addAnnotation(ann)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annView == nil {
            annView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        }
        annView?.isDraggable = true
        annView?.image =  UIImage(named: "04.png")
        
//        UIGraphicsBeginImageContext(CGSize(width: 32, height: 32))
//        initImage?.draw(in: CGSize(width: 32, height: 32))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        annView?.image = newImage
        
        return annView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.removeAnnotation(view.annotation!)
    }

}


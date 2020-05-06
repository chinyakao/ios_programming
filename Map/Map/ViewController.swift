//
//  ViewController.swift
//  Map
//
//  Created by mac23 on 2020/4/30.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
////        let mapView = view.subviews.first as? MKMapView
//        let ann = MKPointAnnotation()
//        ann.coordinate = CLLocationCoordinate2D(latitude: 24.137426, longitude: 121.275753)
////        ann.title = "NTUST"
////        ann.subtitle = "Taipei City"
//        ann.title = "武嶺"
//        mapView?.addAnnotation(ann)
        
//        mapView.mapType = .satellite
        mapView.mapType = .hybrid
        
        var points = [CLLocationCoordinate2D]()
        points.append(CLLocationCoordinate2D(latitude: 24.2013, longitude: 120.5810))
        points.append(CLLocationCoordinate2D(latitude: 24.2044, longitude: 120.6559))
        points.append(CLLocationCoordinate2D(latitude: 24.1380, longitude: 120.6401))
        points.append(CLLocationCoordinate2D(latitude: 24.1424, longitude: 120.5783))
        
        let polygon = MKPolygon(coordinates: &points, count: points.count)
        mapView.addOverlay(polygon)
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolygonRenderer(overlay: overlay)
        if overlay is MKPolygon{
            render.fillColor = UIColor.red.withAlphaComponent(0.2)
            
            render.strokeColor = UIColor.red.withAlphaComponent(0.7)
            
            render.lineWidth = 3
        }
        return render
    }
    @objc func buttonPress(_ sender: UIButton){
        if sender.tag == 100{
            let url = URL(string: "http://www.taroko.gov.tw")
            let safari = SFSafariViewController(url: url!)
            show(safari, sender: self)
        }
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            return nil
//        }
//        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
//        if annView == nil {
////            annView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
//            annView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
//        }
//
//        if(annotation.title)! == "武嶺"{
//            let wulingImg = UIImage(named: "wuling.jpg")
//            let newWulingImg = resizeImage(image: wulingImg!, width: 50)
//            let imageView = UIImageView(image: newWulingImg)
//            annView?.leftCalloutAccessoryView = imageView
//
//            let label = UILabel()
//            label.numberOfLines = 2
//            label.text = "緯度:\(annotation.coordinate.latitude)\n經度:\(annotation.coordinate.longitude)"
//            annView?.detailCalloutAccessoryView = label
//
//            let button = UIButton(type: .detailDisclosure)
//            button.tag = 100
//            button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
//
//            annView?.rightCalloutAccessoryView = button
//        }
//
//        annView?.canShowCallout = true
//
////        let image =  UIImage(named: "04.png")
////        annView?.image = resizeImage(image: image!, width: 32)
////        annView?.isDraggable = true
//        return annView
//    }
    func resizeImage(image: UIImage, width: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: image.size.height * width / image.size.width)
        let renderer = UIGraphicsImageRenderer(size: size)
        let newImage = renderer.image {(context) in image.draw(in: renderer.format.bounds)}
        return newImage
    }
    
//    刪除annotation
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        mapView.removeAnnotation(view.annotation!)
//    }

}


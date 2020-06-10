import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController , CLLocationManagerDelegate,MKMapViewDelegate{

    let fullSize :CGSize = UIScreen.main.bounds.size
    let myUserDefaults :UserDefaults = UserDefaults.standard
    var fetchType :String = ""
    var info :[String:AnyObject]! = nil
    var latitude :Double = 0.0
    var longitude :Double = 0.0
    var myMapView :MKMapView!
    
    let userLocationManager = CLLocationManager()
    var nowUserLocation: CLLocationCoordinate2D!
    
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
        
        userLocationManager.delegate = self
        userLocationManager.requestWhenInUseAuthorization()
        userLocationManager.startUpdatingLocation()

        
        let latDelta = 0.005
        let longDelta = 0.005
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: longDelta)

        let center:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        myMapView.setRegion(currentRegion, animated: true)

        self.view.addSubview(myMapView)
        
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(latitude: latitude, longitude: longitude).coordinate
        objectAnnotation.title = self.title
        myMapView.addAnnotation(objectAnnotation)
        
    }
    
    @objc func buttonPress(_ sender: UIButton){
        if sender.tag == 100 {
            let pstartCoor = CLLocationCoordinate2D(latitude: nowUserLocation!.latitude, longitude: nowUserLocation!.longitude)
            let pstart = MKPlacemark(coordinate: pstartCoor)
            let pendCoor = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let pend = MKPlacemark(coordinate: pendCoor)
            let mistart = MKMapItem(placemark: pstart)
            let misend = MKMapItem(placemark: pend)
            mistart.name = "使用者位置"
            misend.name = self.title
            let routes = [mistart, misend]
            let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            MKMapItem.openMaps(with: routes, launchOptions:options)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("func locationManager is action")
        let c  = locations[0]
        nowUserLocation = CLLocationCoordinate2D(latitude: c.coordinate.latitude, longitude: c.coordinate.longitude)
        
        print("nowUserLocation", nowUserLocation.latitude)
        print(nowUserLocation.longitude)

    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if(annView == nil){
            annView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        }
        if (annotation.title) == self.title {
            let imgView = UIImageView(image: UIImage(named: "landmark"))
            annView?.leftCalloutAccessoryView = imgView
            
            let label = UILabel()
            label.numberOfLines = 2
            label.text = "緯度: \(annotation.coordinate.latitude) \n經度: \(annotation.coordinate.longitude)"
            annView?.detailCalloutAccessoryView = label
            
            let button = UIButton(type: .detailDisclosure)
            button.tag = 100
            if #available(iOS 13.0, *) {
                button.setImage(UIImage(systemName: "location"), for: [])
            }
            button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
            
            annView?.rightCalloutAccessoryView = button
        }
        annView?.canShowCallout = true
        return annView
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

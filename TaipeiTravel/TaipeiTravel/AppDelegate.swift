import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {

    var window: UIWindow?
    var myLocationManager:CLLocationManager!
    var myUserDefaults:UserDefaults!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.myUserDefaults = UserDefaults.standard
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        if CLLocationManager.authorizationStatus() == .notDetermined{
            myLocationManager.requestWhenInUseAuthorization()
        }
        else  if (CLLocationManager.authorizationStatus() == .denied){
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        }
        else if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
            self.myUserDefaults.set(true, forKey: "locationAuth")
            for type in ["hotel","landmark","park","toilet"]{
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLatitude")
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLongitude")
            }
            self.myUserDefaults.synchronize()
        }
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 0.24, green: 0.79, blue: 0.83, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.black
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let myTabBar = UITabBarController()
        
        let landmarkViewController = UINavigationController(rootViewController: LandmarkMainViewController())
        landmarkViewController.tabBarItem = UITabBarItem(title: "景點", image: UIImage(named:"landmark"), tag: 200)
        let parkViewController = UINavigationController(rootViewController: ParkMainViewController())
        parkViewController.tabBarItem = UITabBarItem(title: "公園", image: UIImage(named: "park"), tag: 300)
        let toiletViewController = UINavigationController(rootViewController: ToiletMainViewController())
        toiletViewController.tabBarItem = UITabBarItem(title: "廁所", image: UIImage(named: "toilet"), tag: 400)
        let hotelViewController = UINavigationController(rootViewController: HotelMainViewController())
        hotelViewController.tabBarItem = UITabBarItem(title: "住宿", image: UIImage(named: "hotel"), tag: 100)
        let infoViewController = UINavigationController(rootViewController: InfoMainViewController())
        infoViewController.tabBarItem = UITabBarItem(title: "關於", image: UIImage(named: "info"), tag: 500)
        
        myTabBar.viewControllers = [landmarkViewController,parkViewController,toiletViewController,hotelViewController,infoViewController]
        
        self.window!.rootViewController = myTabBar
        self.window!.makeKeyAndVisible()
        
        return true
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status  == CLAuthorizationStatus.denied){
            let alertController = UIAlertController(title: "定位服務已關閉", message: "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            let okAtion = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertController.addAction(okAtion)
            self.window?.rootViewController?.present(alertController,animated: true,completion: nil)
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        }
        else if(status == CLAuthorizationStatus.authorizedWhenInUse){
            self.myUserDefaults.set(true, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        }
    }
}


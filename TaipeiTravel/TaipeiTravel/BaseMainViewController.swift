import UIKit
import CoreLocation

class BaseMainViewController: UIViewController,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,URLSessionDelegate,URLSessionDownloadDelegate {
    
    var fullSize:CGSize!
    var myUserDefaults:UserDefaults!
    var myLocationManager:CLLocationManager!
    var fetchType:String!
    let refreshDays:Int = 5
    var myActivityIndicator:UIActivityIndicatorView!
    var myTableView:UITableView!
    var todayDateInt:Int!
    var taipeiDataUrl:String!
    var targetUrl:URL!
    var strTargetID:String!
    var apiDataAll:[AnyObject]!
    var apiData:[AnyObject]!
    var apiDataForDistance:[Coordinate]!
    
    let limitDistance = 500.0
    let limitNumber = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullSize = UIScreen.main.bounds.size
        self.myUserDefaults = UserDefaults.standard
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        self.todayDateInt = Int(dateFormatter.string(from: Date()))!
        
        self.taipeiDataUrl = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid="
        
        myActivityIndicator = UIActivityIndicatorView(style: .gray)
        myActivityIndicator.center = CGPoint(x: self.fullSize.width*0.5, y: self.fullSize.height*0.4)
        myActivityIndicator.startAnimating()
        myActivityIndicator.hidesWhenStopped = true
        self.view.addSubview(myActivityIndicator)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (CLLocationManager.authorizationStatus() == .denied){
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        } else if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
            self.myUserDefaults.set(true, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
            myLocationManager.startUpdatingLocation()
        }
        if let table = self.myTableView{
            myActivityIndicator.startAnimating()
            self.refreshAPIData()
            table.reloadData()
            myActivityIndicator.stopAnimating()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        myLocationManager.stopUpdatingLocation()
    }
    
    func addData(){
        let fetchDate = myUserDefaults.object(forKey: self.fetchType+"FetchDate")as?Int
        let date = fetchDate ?? 0
        if self.todayDateInt - date > self.refreshDays{
            self.normalGet(self.taipeiDataUrl + self.strTargetID)
        }
        else{
            self.addTable(self.targetUrl)
        }
    }
    func addTable(_ filePath:URL?){
        if let path = filePath{
            self.jsonParse(path)
        }
        self.myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.fullSize.width, height: self.fullSize.height-113), style: .plain)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.allowsSelection = true
        self.view.addSubview(self.myTableView)
        myActivityIndicator.stopAnimating()
    }
    func goDetail(_ index:Int){
        print("goDetail:\(index)")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations[0] as CLLocation
        self.myUserDefaults.set(currentLocation.coordinate.latitude,forKey: "userLatitude")
        self.myUserDefaults.set(currentLocation.coordinate.longitude,forKey: "userLongitude")
        self.myUserDefaults.synchronize()
        if let table = self.myTableView{
            self.myActivityIndicator.startAnimating()
            self.refreshAPIData()
            table.reloadData()
            self.myActivityIndicator.stopAnimating()
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied){
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        }
        else if(status == CLAuthorizationStatus.authorizedWhenInUse){
            self.myUserDefaults.set(true, forKey: "locationAuth")
            for type in ["hotel","landmark","park","toilet"]{
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLatitude")
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLongitude")
            }
            self.myUserDefaults.synchronize()
            myLocationManager.stopUpdatingLocation()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.apiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil{
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        cell!.accessoryType = .disclosureIndicator
        let thisData = self.apiData[self.apiDataForDistance[indexPath.row].index]
        if let myLabel = cell!.textLabel{
            if let title = thisData["stitle"] as? String{
                myLabel.text = title as String
            }
            else if let title = thisData["ParkName"] as? String{
                myLabel.text = title as String
            }
            else if let title = thisData["單位名稱"] as? String{
                myLabel.text = title as String
            }
        }
        cell!.detailTextLabel?.text = ""
        let locationAuth = myUserDefaults.object(forKey: "locationAuth") as? Bool
        if locationAuth != nil && locationAuth!{
            let userLaitude = myUserDefaults.double(forKey: "userLatitude")
            let userLongitude = myUserDefaults.double(forKey: "userLongitude")
            let userLocation = CLLocation(latitude: userLaitude, longitude: userLongitude)
            var thisDataLatitude = 0.0
            if let num = thisData["latitude"] as? String{
                thisDataLatitude = Double(num)!
            }
            else if let num = thisData["Latitude"] as? String{
                thisDataLatitude = Double(num)!
            }
            else if let num = thisData["緯度"]as? String{
                thisDataLatitude = Double(num)!
            }
            var thisDataLongitude = 0.0
            if let num = thisData["longitude"] as? String{
                thisDataLongitude = Double(num)!
            }
            else if let num = thisData["Longitude"] as? String{
                thisDataLongitude = Double(num)!
            }
            else if let num = thisData["經度"]as? String{
                thisDataLongitude = Double(num)!
            }
            if thisDataLatitude == 0.0 && thisDataLongitude == 0.0{
                cell!.detailTextLabel?.text = ""
            }
            else{
                let thisDataLocation = CLLocation(latitude: thisDataLatitude, longitude: thisDataLongitude)
                let distance = Int(userLocation.distance(from: thisDataLocation))
                var detail = ""
                if distance > 20000{
                    detail = "超過 20 KM"
                }
                else if distance > 1000{
                    detail = "\(Double(Int(distance / 100)) / 10.0)KM"
                }
                else if distance > 100{
                    detail = "\(Int(distance / 10))0M"
                }
                else{
                    detail = "\(distance)M"
                }
                cell!.detailTextLabel?.text = detail
            }
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.goDetail(indexPath.row)
        
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do{
            let data = try? Data(contentsOf: location)
            try data?.write(to: self.targetUrl, options: .atomic)
            print("普通獲取遠單資訊的方式：儲存資訊成功")
            self.myUserDefaults.set(self.todayDateInt, forKey: self.fetchType+"FetchDate")
            self.myUserDefaults.synchronize()
            DispatchQueue.main.sync(execute: {
                self.addTable(self.targetUrl)
            })
        }catch{
            print("普通獲取遠單資訊的方式：儲存資訊失敗")
        }
    }
    func normalGet(_ myUrl:String){
        if let url = URL(string: myUrl){
            let sessionWitchConfigure = URLSessionConfiguration.default
            let session = Foundation.URLSession(configuration: sessionWitchConfigure, delegate: self, delegateQueue: nil)
            let dataTask = session.downloadTask(with: url)
            dataTask.resume()
        }
    }
    func jsonParse(_ url:URL){
        do{
            let dict = try JSONSerialization.jsonObject(with: Data(contentsOf: url), options: JSONSerialization.ReadingOptions.allowFragments) as! [String:[String:AnyObject]]
            let dataArr = dict["result"]!["results"] as! [AnyObject]
            self.apiDataAll = dataArr
            self.refreshAPIData()
            
        }catch{
            print("解析json失敗")
        }
    }
    func fetchLatitudeAndLongitudeFromData(_ data : AnyObject)->(latitude:Double,longitude:Double){
        var latitude = 0.0
        if let num = data["latitude"] as? String{
            latitude = Double(num)!
        }
        else if let num = data["Latitude"] as? String{
            latitude = Double(num)!
        }
        else if let num = data["緯度"]as? String{
            latitude = Double(num)!
        }
        var longitude = 0.0
        if let num = data["longitude"] as? String{
            longitude = Double(num)!
        }
        else if let num = data["Longitude"] as? String{
            longitude = Double(num)!
        }
        else if let num = data["經度"]as? String{
            longitude = Double(num)!
        }
        return(latitude,longitude)
    }
    func fillIntoAPIDataForDistanceAndSort(_ allData:[AnyObject]){
        self.apiDataForDistance = []
        var index = 0
        for data in allData{
            let (latitude,longitude) = self.fetchLatitudeAndLongitudeFromData(data)
            self.apiDataForDistance.append(Coordinate(
                index:index,
                latitude:latitude,
                longitude:longitude
            ))
            index += 1
        }
        self.apiDataForDistance.sort(by: <)
    }
    func reloadAPIData(){
        guard self.apiDataAll != nil else{
            return
        }
        let locationAuth = myUserDefaults.object(forKey: "locationAuth") as? Bool
        if locationAuth != nil && locationAuth!{
            let userLatitude = myUserDefaults.double(forKey: "userLatitude")
            let userLongitude = myUserDefaults.double(forKey: "userLongitude")
            let userLocation = CLLocation(latitude: userLatitude, longitude: userLongitude)
            
            let recordLatitude = myUserDefaults.object(forKey: self.fetchType + "RecordLatitude") as? Double ?? 0.0
            let recordLongitude = myUserDefaults.object(forKey: self.fetchType + "RecordLongitude") as? Double ?? 0.0
            let recordLocation = CLLocation(latitude: recordLatitude, longitude: recordLongitude)
            
            if userLocation.distance(from: recordLocation) > self.limitDistance{
                self.fillIntoAPIDataForDistanceAndSort(self.apiDataAll)
                var tempAPIData :[AnyObject] = []
                var tempAPIDataForDistance:[Coordinate] = []
                for index in 0...self.limitNumber{
                    let tempCoordinate = self.apiDataForDistance[index]
                    let tempData = self.apiDataAll[tempCoordinate.index]
                    tempAPIData.append(tempData)
                    let (latitude,longitude) = self.fetchLatitudeAndLongitudeFromData(tempData)
                    tempAPIDataForDistance.append(Coordinate(
                        index:index,
                        latitude:latitude,
                        longitude:longitude
                    ))
                }
                self.apiData = tempAPIData
                self.apiDataForDistance = tempAPIDataForDistance
                myUserDefaults.set(userLatitude,forKey: self.fetchType + "RecordLatitude")
                myUserDefaults.set(userLongitude,forKey: self.fetchType + "RecordLongitude")
                myUserDefaults.synchronize()
            }
            else{
                self.apiData = self.apiDataAll
            }
        }
    }
    func refreshAPIData(){
        guard self.apiDataAll != nil else{
            return
        }
        self.reloadAPIData()
        self.fillIntoAPIDataForDistanceAndSort(self.apiData)
    }
    
    
    
    
    
    
    
}


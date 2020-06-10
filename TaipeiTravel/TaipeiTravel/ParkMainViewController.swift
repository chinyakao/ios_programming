import UIKit

class ParkMainViewController: BaseMainViewController {

   override func viewDidLoad() {
       super.viewDidLoad()

       self.title = "公園"
       
       self.fetchType = "park"
       
       self.strTargetID = "8f6fcb24-290b-461d-9d34-72ed1b3f51f0"
       
       self.targetUrl = {
           do{
               return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(self.fetchType + ".json")
           }catch{
               fatalError("Error getting file URL from doccument directory.")
           }
       }()
       
    self.addData()
       // Do any additional setup after loading the view.
   }
   override func goDetail(_ index:Int){
        let thisData = self.apiData[self.apiDataForDistance[index].index]
        let title = thisData["ParkName"] as? String ?? ""
        let intro = thisData["Introduction"] as? String ?? ""
        var area = thisData["Area"] as? String ?? "無面積資訊"
       
        if area != "無面積資訊"{
            area = "面積: " + area + " 平方公尺"
        }
    
        let type = thisData["ParkType"] as? String ?? ""
        let location = thisData["Location"] as? String ?? "無地址資訊"
    
    
        var latitude = 0.0
        if let num  = thisData["latitude"] as? String{
            latitude = Double(num)!
        }
        var longitude = 0.0
        if let num  = thisData["longitude"] as? String{
            longitude = Double(num)!
        }
       
        let info:[String:AnyObject] = [
            "title":title as AnyObject,
            "intro":intro as AnyObject,
            "type":type as AnyObject,
            "location":location as AnyObject,
            "area":area as AnyObject,
            "latitude":latitude as AnyObject,
            "longitude":longitude as AnyObject,
        ]
       
        print(info["title"] as? String ?? "No Title")
       
        let detailViewController = ParkDetailViewController()
        detailViewController.info = info
       
        self.navigationController?.pushViewController(detailViewController, animated: true)
   }
}

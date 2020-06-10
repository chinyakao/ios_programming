import UIKit
import CoreLocation

class LandmarkMainViewController: BaseMainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "景點"
        
        self.fetchType = "landmark"
        
        self.strTargetID = "36847f3f-deff-4183-a5bb-800737591de5"
        
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
        let title = thisData["stitle"] as? String ?? ""
        let intro = thisData["xbody"] as? String ?? ""
        let opentime = thisData["MEMO_TIME"] as? String ?? "無開放時間資訊"
        let transportation = thisData["info"] as? String ?? "無交通資訊"
        let type = thisData["CAT2"] as? String ?? ""
        let address = thisData["address"] as? String ?? "無地址資訊"
        
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
            "address":address as AnyObject,
            "opentime":opentime as AnyObject,
            "transportation":transportation as AnyObject,
            "latitude":latitude as AnyObject,
            "longitude":longitude as AnyObject,
        ]
        
        print(info["title"] as? String ?? "No Title")
        
        let detailViewController = LandmarkDetailViewController()
        detailViewController.info = info
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
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

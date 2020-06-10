import UIKit

class ToiletDetailViewController: DetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fetchType = "toilet"
        
        let latitude = info["latitude"] as? Double ?? 0.0
        let longitude = info["longitude"] as? Double ?? 0.0
        hasMap = latitude == 0.0 && longitude == 0.0 ? false : true
        
        detail = [
        "地圖",
        info["type"] as? String ?? "",
        info["address"] as? String ?? "",
        info["number"] as? String ?? "",
        info["type1"] as? String ?? "",
        info["type2"] as? String ?? "",
        info["type3"] as? String ?? "",
        ]

        self.title = info["title"] as? String ?? "標題"
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

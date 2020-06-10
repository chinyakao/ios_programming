import UIKit

class LandmarkDetailViewController: DetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchType = "landmark"
        
        let latitude = info["latitude"] as? Double ?? 0.0
        let longitude = info["longitude"] as? Double ?? 0.0
        hasMap = latitude == 0.0 && longitude == 0.0 ? false : true
        
        detail = [
        "地圖",
        info["type"] as? String ?? "",
        info["address"] as? String ?? "",
        info["opentime"] as? String ?? "",
        info["transportation"] as? String ?? "",
        info["intro"] as? String ?? "",
        ]

        self.title = info["title"] as? String ?? "標題"
        // Do any additional setup after loading the view.
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


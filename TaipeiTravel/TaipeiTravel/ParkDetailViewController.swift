import UIKit

class ParkDetailViewController: DetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fetchType = "park"
        
        let latitude = info["latitude"] as? Double ?? 0.0
        let longitude = info["longitude"] as? Double ?? 0.0
        hasMap = latitude == 0.0 && longitude == 0.0 ? false : true
        
        detail = [
        "地圖",
        info["type"] as? String ?? "",
        info["address"] as? String ?? "",
        info["area"] as? String ?? "",
        info["intro"] as? String ?? "",
        ]

        self.title = info["title"] as? String ?? "標題"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hasMap ?  5 : 4
    }

}

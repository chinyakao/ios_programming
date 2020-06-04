//
//  HotelDetailViewController.swift
//  TaipeiTravel
//
//  Created by mac25 on 2020/5/20.
//  Copyright © 2020 hsin. All rights reserved.
//

import UIKit

class HotelDetailViewController: DetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.fetchType = "hotel"
        
        let latitude = info["latitude"] as? Double ?? 0.0
        let longitude = info["longitude"] as? Double ?? 0.0
        hasMap = latitude == 0.0 && longitude == 0.0 ? false : true
        
        detail = [
        "地圖",
        info["type"] as? String ?? "",
        info["address"] as? String ?? "",
        info["intro"] as? String ?? "",
        ]

        self.title = info["title"] as? String ?? "標題"
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat(44.0)
        
        if(self.hasMap && indexPath.row == 3)||(!self.hasMap && indexPath.row == 2){
            height = self.myTableView.frame.size.height - height * CGFloat(indexPath.row + 1)
        }
        else if(self.hasMap && indexPath.row == 2) || (!self.hasMap && indexPath.row == 1){
            height = 2.0*height
        }
        
        if indexPath.row == self.selectedRowIndex{
            height = max(height, self.rowHeight + 5)
        }
        return height
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

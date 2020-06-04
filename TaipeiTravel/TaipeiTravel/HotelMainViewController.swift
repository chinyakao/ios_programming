//
//  HotelMainViewController.swift
//  TaipeiTravel
//
//  Created by mac25 on 2020/5/20.
//  Copyright © 2020 hsin. All rights reserved.
//

import UIKit

class HotelMainViewController: BaseMainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "住宿"
        
        self.fetchType = "hotel"
        
        self.strTargetID = "6f4e0b9b-8cb1-4b1d-a5c4-febd90f22469"
        
        self.targeUrl = {
            do{
                return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(self.fetchType + ".json")
            }catch{
                fatalError("Error getting file URL from doccument directory.")
            }
        }()
        
        // Do any additional setup after loading the view.
        self.addData()
    }
    override func goDetail(_ index:Int){
        let thisData = self.apiData[self.apiDataForDistance[index].index]
        let title = thisData["stitle"] as? String ?? ""
        let intro = thisData["xbody"] as? String ?? ""
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
            "latitude":latitude as AnyObject,
            "longitude":longitude as AnyObject,
        ]
        
        print(info["title"] as? String ?? "No Title")
        
        let detailViewController = HotelDetailViewController()
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

//
//  ToiletMainViewController.swift
//  TaipeiTravel
//
//  Created by mac25 on 2020/5/20.
//  Copyright © 2020 hsin. All rights reserved.
//

import UIKit

class ToiletMainViewController: BaseMainViewController {
        override func viewDidLoad() {
              super.viewDidLoad()

              self.title = "廁所"
              
              self.fetchType = "toilet"
              
              self.strTargetID = "008ed7cf-2340-4bc4-e258a5573be2"
              
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
               let type = thisData["類別"] as? String ?? ""
            
            
               var number = thisData["座敷"] as? String ?? ""
                if number != ""{
                    number = "座敷： " + number
                }

            
               let type1 = thisData["場所提供行動不便者使用廁所"] as? String ?? ""
               let type2 = thisData["親子廁間"] as? String ?? ""
               let type3 = thisData["貼心公廁"] as? String ?? ""
            
               let title = thisData["ParkName"] as? String ?? "單位名稱"
               let address = thisData["地址"] as? String ?? ""
            
            
               var latitude = 0.0
               if let num  = thisData["緯度"] as? String{
                   latitude = Double(num)!
               }
               var longitude = 0.0
               if let num  = thisData["經度"] as? String{
                   longitude = Double(num)!
               }
              
               let info:[String:AnyObject] = [
                   "title":title as AnyObject,
                   "number":number as AnyObject,
                   "type":type as AnyObject,
                   "address":address as AnyObject,
                   "type1":type1 as AnyObject,
                   "type2":type2 as AnyObject,
                   "type3":type3 as AnyObject,
                   "latitude":latitude as AnyObject,
                   "longitude":longitude as AnyObject,
               ]
              
               print(info["title"] as? String ?? "No Title")
              
               let detailViewController = ToiletDetailViewController()
               detailViewController.info = info
              
               self.navigationController?.pushViewController(detailViewController, animated: true)
          }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



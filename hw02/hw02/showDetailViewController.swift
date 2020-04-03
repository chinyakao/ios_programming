//
//  showDetailViewController.swift
//  hw02
//
//  Created by Riley on 2020/4/4.
//  Copyright © 2020 Riley. All rights reserved.
//

import UIKit

class showDetailViewController: UIViewController {
//    var detailNames = ["Seven-Eleven", "Family-Mart", "Hi-Life"]
//    var detailImg = ["711_icon", "familymart_icon", "hilife_icon"]
    var restaurant: Restaurant!
    var num: Int = 0
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = UIImage(named: restaurant.image)
        detailNameLabel.text = restaurant.name

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

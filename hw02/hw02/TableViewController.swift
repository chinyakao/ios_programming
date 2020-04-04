//
//  TableViewController.swift
//  hw02
//
//  Created by Riley on 2020/4/3.
//  Copyright © 2020 Riley. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var currentEditingMode = 1
    var addLock = false
    var delLock = false
    var restaurants:[Restaurant] = [
    Restaurant(name: "Seven-Eleven", image: "711_icon"),
    Restaurant(name: "Family-Mart", image: "familymart_icon"),
    Restaurant(name: "Hi-Life", image: "hilife_icon"),
    ]
    
   
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var delButton: UIButton!
    @IBOutlet var myTableView: UITableView!
    

    @IBAction func add(_ sender: UIButton) {
        if(delLock == false && !tableView.isEditing){
               //tableView.isEditing = false
               addButton.setTitle("返回", for: .normal)
               currentEditingMode = 1
               addLock = true
               tableView.setEditing(true, animated: true)
               
           } else if(addLock == true && tableView.isEditing){
               //tableView.isEditing = true
               addLock = false
               addButton.setTitle("新增", for: .normal)
               tableView.setEditing(false, animated: true)
           }
        
       
    }

    @IBAction func del(_ sender: UIButton) {
        if(addLock == false && !tableView.isEditing){
            delButton.setTitle("返回", for: .normal)
            currentEditingMode = 2
            delLock = true
            tableView.setEditing(true, animated: true)
        } else if(delLock == true && tableView.isEditing){
            //tableView.isEditing = true
            delLock = false
            delButton.setTitle("刪除", for: .normal)
            tableView.setEditing(false, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "刪除", style: UIBarButtonItem.Style.plain, target: navigationController, action: #selector(setEditing(_:animated:)))
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "新增", style: UIBarButtonItem.Style.plain, target: navigationController, action: #selector(setEditing(_:animated:)))
        
        //myTableView.setEditing(true, animated: false)
        //self.delBtnAction()
        //myTableView.isEditing = true
        //self.addBtnAction()
        
        
        
    }
    
//    // 按下編輯按鈕時執行動作的方法
//    @objc func delBtnAction() -> UITableViewCell.EditingStyle {
//        myTableView.setEditing(!myTableView.isEditing, animated: true)
//        if (!myTableView.isEditing) {
//            // 顯示編輯按鈕
//            self.navigationItem.rightBarButtonItem =
//                UIBarButtonItem(title: "刪除", style: .plain,
//              target: self,
//              action:
//                #selector(self.delBtnAction))
//        } else {
//            // 顯示編輯完成按鈕
//            self.navigationItem.rightBarButtonItem =
//                UIBarButtonItem(title: "返回", style: .done,
//                target: self,
//                action:
//                  #selector(self.delBtnAction))
//        }
//        return .delete
//    }
//    @objc func addBtnAction() -> UITableViewCell.EditingStyle{
//        myTableView.setEditing(!myTableView.isEditing, animated: true)
//        if (!myTableView.isEditing) {
//            // 顯示新增按鈕
//            self.navigationItem.leftBarButtonItem =
//                UIBarButtonItem(title: "新增", style: .plain,
//              target: self,
//              action:
//                #selector(self.addBtnAction))
//        } else {
//
//            // 隱藏新增按鈕
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(self.addBtnAction))
//        }
//        return .insert
//    }
    
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        // Toggles the edit button state
//        super.setEditing(editing, animated: animated)
//        // Toggles the actual editing actions appearing on a table view
//        tableView.setEditing(editing, animated: true)
//
//        if (self.isEditing) {
//            navigationItem.rightBarButtonItem =
//                UIBarButtonItem(barButtonSystemItem: .add, target: self,
//                                action: #selector(clickMe))
//
//        } else {
//            // we're not in edit mode
//            let newButton = UIBarButtonItem(title: "hhh", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
//            navigationItem.rightBarButtonItem = newButton
//        }
//
//    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = restaurants[indexPath.row].name
        cell.imageView?.image = UIImage(named: restaurants[indexPath.row].image)
        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "showDetail" {
              if let indexPath = tableView.indexPathForSelectedRow {
                  let destinationController = segue.destination as! showDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
              }
          }
      }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            restaurants.insert(restaurants[indexPath.row], at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt: IndexPath) -> UITableViewCell.EditingStyle{
        switch currentEditingMode {
        case 0:
            return .none
        case 1:
            return .insert
        case 2:
            return .delete
        default:
            break
        }
        return .none
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

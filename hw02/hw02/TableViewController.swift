//
//  TableViewController.swift
//  hw02
//
//  Created by Riley on 2020/4/3.
//  Copyright © 2020 Riley. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var editingStyle = 0
    
    var restaurants:[Restaurant] = [
    Restaurant(name: "Seven-Eleven", image: "711_icon"),
    Restaurant(name: "Family-Mart", image: "familymart_icon"),
    Restaurant(name: "Hi-Life", image: "hilife_icon"),
    ]
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var delButton: UIButton!
    

//    @IBAction func add(_ sender: UIButton) {
//        if(tableView.isEditing){
//            tableView.isEditing = false
//            addButton.setTitle("新增", for: .normal)
//            editingStyle = 1
//        } else{
//            tableView.isEditing = true
//            addButton.setTitle("返回", for: .normal)
//            editingStyle = 0
//        }
//    }
//
//    @IBAction func del(_ sender: UIButton) {
//        if(tableView.isEditing){
//            tableView.isEditing = false
//            delButton.setTitle("刪除", for: .normal)
//            editingStyle = 2
//        } else{
//            tableView.isEditing = true
//            delButton.setTitle("返回", for: .normal)
//            editingStyle = 0
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "刪除", style: UIBarButtonItem.Style.plain, target: navigationController, action: #selector(setEditing(_:animated:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "新增", style: UIBarButtonItem.Style.plain, target: navigationController, action: #selector(setEditing(_:animated:)))
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        // Toggles the edit button state
        super.setEditing(editing, animated: animated)
        // Toggles the actual editing actions appearing on a table view
        tableView.setEditing(editing, animated: true)

        if (self.isEditing) {
            navigationItem.rightBarButtonItem =
                UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                action: #selector(clickMe))

        } else {
            // we're not in edit mode
            let newButton = UIBarButtonItem(title: "hhh", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
            navigationItem.rightBarButtonItem = newButton
        }

    }


    @objc func clickMe()
    {
        print("Button Clicked")
    }

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
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
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return .delete
        
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

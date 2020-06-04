//
//  InfoMainViewController.swift
//  TaipeiTravel
//
//  Created by mac25 on 2020/5/20.
//  Copyright © 2020 hsin. All rights reserved.
//

import UIKit

class InfoMainViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let fullSize:CGSize = UIScreen.main.bounds.size
    var myTableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "關於"
        
        self.myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.fullSize.width, height: self.fullSize.height - 113),style: .grouped)
        self.myTableView.register(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.allowsSelection = true
        self.view.addSubview(self.myTableView)
    }
    @objc func goFB(){
        let reqestURL = URL(string: "https://www.facebook.com/swiftgogogo")
        UIApplication.shared.open(reqestURL!)
    }
    @objc func goIconSource(){
        let reqestURL = URL(string: "https://www.flaticon.com/")
        UIApplication.shared.open(reqestURL!)
    }
    @objc func goDataSource(){
        let reqestURL = URL(string: "https://data.taipei/")
        UIApplication.shared.open(reqestURL!)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 1) ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let fbButton = UIButton(frame: CGRect(x: 15, y: 0, width: fullSize.width, height: 40))
                fbButton.addTarget(self, action: #selector(InfoMainViewController.goFB), for: .touchUpInside)
                fbButton.setTitle("在FB上與我們聯絡", for: .normal)
                fbButton.setTitleColor(UIColor.black, for: .normal)
                fbButton.contentHorizontalAlignment = .left
                cell.contentView.addSubview(fbButton)
            }
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let button = UIButton(frame: CGRect(x: 15, y: 0, width: fullSize.width, height: 40))
                button.addTarget(self, action: #selector(InfoMainViewController.goFB), for: .touchUpInside)
                button.setTitle("資料：台北市政府資料開放平臺", for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.contentHorizontalAlignment = .left
                cell.contentView.addSubview(button)
            }else{
                let button = UIButton(frame: CGRect(x: 15, y: 0, width: fullSize.width, height: 40))
                button.addTarget(self, action: #selector(InfoMainViewController.goFB), for: .touchUpInside)
                button.setTitle("圖示：FLATION", for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.contentHorizontalAlignment = .left
                cell.contentView.addSubview(button)
            }
       }else if indexPath.section == 2 {
            cell.textLabel?.text = "當開啟定位服務時，顯示資料僅會列出距離目前定位位置較近的地點。"
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
       }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = "說明"
        if section == 0{
            title = "支援"
        }else if section == 1{
            title = "來源"
        }
        return title
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat(44.0)
        if indexPath.section == 2{
            height = 120.0
        }
        return height
    }
}

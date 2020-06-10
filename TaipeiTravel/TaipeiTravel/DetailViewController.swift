import UIKit

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    let fullSize:CGSize = UIScreen.main.bounds.size
    let myUserDefaults :UserDefaults = UserDefaults.standard
    var fetchType :String = ""
    var info :[String:AnyObject]! = nil
    var detail :[String] = []
    var hasMap :Bool = false
    var myTableView :UITableView!
    var selectedRowIndex :Int = -1
    var rowHeight :CGFloat = 88.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.fullSize.width, height: self.fullSize.height-113), style: .plain)
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.allowsSelection = true
        self.view.addSubview(self.myTableView)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hasMap ? 6 : 5
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .none
        if self.hasMap{
            cell.textLabel?.text = self.detail[indexPath.row]
            if indexPath.row == 0{
                cell.accessoryType = .disclosureIndicator
            }
            else if indexPath.row == 1{
                cell.textLabel?.text = "類型：" + (cell.textLabel?.text)!
            }
        }
        else{
            cell.textLabel?.text = self.detail[indexPath.row + 1]
            if indexPath.row == 0{
                cell.textLabel?.text = "類型：" + (cell.textLabel?.text)!
            }
        }
        if indexPath.row > (self.hasMap ? 1 : 0){
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
        }
        return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.hasMap && indexPath.row == 0{
            let viewController = MapViewController()
            viewController.info = self.info
            viewController.fetchType = self.fetchType
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else{
            let cell = myTableView.cellForRow(at: indexPath)
            let label = cell?.textLabel
            if indexPath.row == self.selectedRowIndex{
                self.rowHeight = 88.0
                self.selectedRowIndex = -1
            }
            else{
                label?.preferredMaxLayoutWidth = fullSize.width * 0.9
                let intrinsicSize = label?.intrinsicContentSize
                self.rowHeight = (intrinsicSize?.height)!
                self.selectedRowIndex = indexPath.row
            }
            myTableView.beginUpdates()
            myTableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat(44.0)
        
        if (self.hasMap && indexPath.row >= 2) || (!self.hasMap && indexPath.row >= 1){
            height = 2.0 * height
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

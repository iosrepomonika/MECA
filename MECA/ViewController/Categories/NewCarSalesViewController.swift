//

import UIKit

class NewCarSalesViewController: UIViewController {
    @IBOutlet weak var varNewCarSaleTblView : UITableView!
    @IBOutlet weak var lblHeader: UILabel!
    
    var viewModel : HomeVM!
    var strComeFrom = ""
    var type  = 0
    var arrList = [DataKaizen]()
    
    
    @IBAction func btnCreateNewAction(_ sender: RCustomButton) {
        let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        varNewCarSaleTblView.register(UINib.init(nibName: "DistributorListTVCell", bundle: nil), forCellReuseIdentifier: "DistributorListTVCell")
        varNewCarSaleTblView.delegate = self
        varNewCarSaleTblView.dataSource = self
        if strComeFrom == "Distributor"{
           
            if type == 1{
                lblHeader.text = "New Car Sales"
            }else if type == 2{
                lblHeader.text = "Trade in"
            }else if type == 3{
                lblHeader.text = "After sales"
            }else{
                lblHeader.text = "Bit Foundation"
            }
            callNewCarSaleWebservice(adminId: 0, type: type)
        }else{
            if type == 1{
                lblHeader.text = "New Car Sales"
            }else if type == 2{
                lblHeader.text = "After sales"
            }else if type == 3 {
                lblHeader.text = "Trade in"
            }else{
                lblHeader.text = "Bit Foundation"
            }
            callNewCarSaleWebservice(adminId: 1, type: type)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
//MARK:- UITableview Delegate Datasource
extension NewCarSalesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DistributorListTVCell", for: indexPath) as! DistributorListTVCell
        let objFeed = arrList[indexPath.row]
        //cell.setCell(feed: objFeed)
        cell.setCellNewCar(feed: objFeed)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 292
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Category", bundle:nil)
        let obj = arrList[indexPath.row]
        let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
     //   vc.navValue = "3"
        vc.eventID = String(obj.id ?? 0)
       vc.isEvent =  false
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    func callNewCarSaleWebservice(adminId: Int, type: Int) {

        let param : [String:Any] = ["is_admin" : adminId,
                                    "type" : type]//"keyword" : "test"
        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForNewCarSale(params: param) { (result) in
            if let repo = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
               
                if repo == 200 {
                    
                    if let arrList = result.data{
                        print(arrList)
                        for obj in arrList {
                            self.arrList.append(obj)
                        }
                        self.varNewCarSaleTblView.reloadData()
                    }
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }else{
                
                self.showToast(message: "Somwthing Went Wrong")
                GlobalObj.displayLoader(true, show: false)
            }
        }
        
        
    }

}

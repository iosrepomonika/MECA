//

import UIKit

class NewCarSalesViewController: UIViewController {
    @IBOutlet weak var varNewCarSaleTblView : UITableView!
    @IBOutlet weak var lblHeader: UILabel!
    private var pullControl = UIRefreshControl()
    @IBOutlet weak var txtSearch: UITextField!
    
    var viewModel : HomeVM!
    var strComeFrom = ""
    var type  = 0
    var arrList = [DataKaizen]()
    var updatedText = ""
    var currentPage : Int = 1
    var checkPagination = ""

    
    @IBAction func btnCreateNewAction(_ sender: RCustomButton) {
        let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.delegate = self
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
            checkPagination = "get"

            callNewCarSaleWebservice(adminId: 0, type: type, keyword: updatedText, page: String(currentPage))
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
            checkPagination = "get"

            callNewCarSaleWebservice(adminId: 1, type: type, keyword: updatedText, page: String(currentPage))
        }
      
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            varNewCarSaleTblView.refreshControl = pullControl
        } else {
            varNewCarSaleTblView.addSubview(pullControl)
        }
        // Do any additional setup after loading the view.
    }
    @objc private func refreshListData(_ sender: Any) {
        currentPage = 1
        //GlobalObj.displayLoader(true, show: true)
        if strComeFrom == "Distributor"{
            checkPagination = "get"

            callNewCarSaleWebservice(adminId: 0, type: type, keyword: updatedText, page: String(currentPage))

        }else{
            checkPagination = "get"

            callNewCarSaleWebservice(adminId: 1, type: type, keyword: updatedText, page: String(currentPage))

        }
        self.pullControl.endRefreshing()



        }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
//MARK:- Textfeild delegate
extension NewCarSalesViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
                   let textRange = Range(range, in: text) {
            updatedText = text.replacingCharacters(in: textRange,with: string)
            currentPage = 1
           //GlobalObj.displayLoader(true, show: false)

            if strComeFrom == "Distributor"{
                checkPagination = "get"

                callNewCarSaleWebservice(adminId: 0, type: type, keyword: updatedText, page: String(currentPage))

            }else{
                checkPagination = "get"

                callNewCarSaleWebservice(adminId: 1, type: type, keyword: updatedText, page: String(currentPage))

            }
        }
        return true
    }
}
//MARK:- UITableview Delegate Datasource
extension NewCarSalesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DistributorListTVCell", for: indexPath) as! DistributorListTVCell
        print(arrList.count)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                if indexPath.row == self.arrList.count-1{
                    self.checkPagination = "pagination"
                    currentPage += 1
                    if self.updatedText == ""{
                    GlobalObj.displayLoader(true, show: true)
                    }
                    GlobalObj.run(after: 2) {
                        if self.strComeFrom == "Distributor"{

                            self.callNewCarSaleWebservice(adminId: 0, type: self.type, keyword: self.updatedText, page: String(self.currentPage))

                        }else{

                            self.callNewCarSaleWebservice(adminId: 1, type: self.type, keyword: self.updatedText, page: String(self.currentPage))

                        }                    }
                }
            }
    }
}
   
    
    func callNewCarSaleWebservice(adminId: Int, type: Int, keyword:String, page:String) {

        let param : [String:Any] = ["is_admin" : adminId,
                                    "type" : type,
                                    "keyword" : keyword]
        print(param)
//        if updatedText == "" {
//            //GlobalObj.displayLoader(true, show: true)
//        }else{
//            //GlobalObj.displayLoader(true, show: false)
//
//        }
        APIClient.webserviceForNewCarSale(limit: "10",page: page,params: param) { (result) in
            if let repo = result.resp_code{
                if self.updatedText == ""{
                    GlobalObj.displayLoader(true, show: false)
                }
               
                if repo == 200 {
                    
                    if let arrListData = result.data{
                        if self.checkPagination == "get"{
                            self.arrList.removeAll()
                        }
                        if arrListData.count == 0{
                            return
                        }
                        
                        for obj in arrListData {
                            self.arrList.append(obj)
                        }
                        self.varNewCarSaleTblView.reloadData()
                    }
                    if self.arrList.count>0{
                        self.varNewCarSaleTblView.isHidden = false
                    }else{
                        self.varNewCarSaleTblView.isHidden = true
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

//
//  SDGSListvc.swift
//  MECA
//
//  Created by Macbook  on 17/04/21.
//

import UIKit

class SDGSListvc: UIViewController {
    
    @IBOutlet weak var varsdgslistTblView : UITableView!
    @IBOutlet weak var lblHeader: UILabel!
    private var pullControl = UIRefreshControl()
    var arrList = [DataMaas]()
    var headerImageValue = ""
    var idvalue = ""
    var currentPage : Int = 1
    var checkPagination = ""
    var updatedText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        varsdgslistTblView.register(UINib.init(nibName: "MaasListTVCell", bundle: nil), forCellReuseIdentifier: "MaasListTVCell")
        varsdgslistTblView.delegate = self
        varsdgslistTblView.dataSource = self
        lblHeader.text! = headerImageValue
        
        callSDGSLISTWebservice(type: Int(idvalue)!)
        
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            varsdgslistTblView.refreshControl = pullControl
        } else {
            varsdgslistTblView.addSubview(pullControl)
        }
    }
    @objc private func refreshListData(_ sender: Any) {
        self.pullControl.endRefreshing()
        currentPage = 1
        self.checkPagination = "get"
        callSDGSLISTWebservice(type: Int(idvalue)!)

    }
    
    func callSDGSLISTWebservice( type: Int) {

        let param : [String:Any] = [
                                    "type" : type]//"keyword" : "test"
        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForSDGSlistapi(limit: "10",page: String(currentPage), params: param) { (result) in
            if let repo = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
               
                if repo == 200 {
                    
                    if let arrList = result.data{
                        print(arrList)
                        if self.checkPagination == "get"{
                            self.arrList.removeAll()
                        }
                        for obj in arrList {
                            self.arrList.append(obj)
                        }
                        self.varsdgslistTblView.reloadData()
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
    @IBAction func btnCreateNewAction(_ sender: RCustomButton) {
        let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
//MARK:- UITableview Delegate Datasource
extension SDGSListvc:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MaasListTVCell", for: indexPath) as! MaasListTVCell
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
        print("String(obj.id ?? 0) sdgs \(String(obj.id ?? 0))")
        vc.eventID = String(obj.id ?? 0)
        vc.isEvent = false
        vc.ComingfromVC = "Sdgs"
        vc.module = "Sdgs"
        vc.Maasview = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                if indexPath.row == arrList.count-1{
                    self.checkPagination = "pagination"
                    currentPage += 1
                    GlobalObj.run(after: 2) {
                        GlobalObj.displayLoader(true, show: true)
                        self.callSDGSLISTWebservice(type: Int(self.idvalue)!)

                    }
                }
            }
        }
    }
    


}

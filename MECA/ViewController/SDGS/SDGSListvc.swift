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
    
    var arrList = [DataMaas]()
    var headerImageValue = ""
    var idvalue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        varsdgslistTblView.register(UINib.init(nibName: "MaasListTVCell", bundle: nil), forCellReuseIdentifier: "MaasListTVCell")
        varsdgslistTblView.delegate = self
        varsdgslistTblView.dataSource = self
        lblHeader.text! = headerImageValue
        
        callSDGSLISTWebservice(type: Int(idvalue)!)
        
        // Do any additional setup after loading the view.
    }

    
    func callSDGSLISTWebservice( type: Int) {

        let param : [String:Any] = [
                                    "type" : type]//"keyword" : "test"
        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForSDGSlistapi(params: param) { (result) in
            if let repo = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
               
                if repo == 200 {
                    
                    if let arrList = result.data{
                        print(arrList)
                        if arrList.count > 0 {
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
        vc.Maasview = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    


}

//
//  SDGSCategorylistvc.swift
//  MECA
//
//  Created by Macbook  on 15/04/21.
//

import UIKit
import SDWebImage
class SDGSCategoryvc: UIViewController  {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: RCustomView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var dismissRefBtn: UIButton!
    @IBOutlet weak var SDGSCategoryTableView: UITableView!
    @IBOutlet weak var footerView: BlueFooterview!
    
    
    var arrowArray = ["NO POVERTY arrow","ZERO HUNGER arrow","GOOD HEALTH AND WELL-BEING arrow","QUALITY EDUCATION arrow","GENDER EQUALITY arrow","CLEAN WATER AND SANITATION arrow","AFFORDABLE AND CLEAN ENERGY arrow","DECENT WORK AND ECONOMIC GROWTH arrow","INDUSTRY, INNOVATION AND INFRASTRUCTURE arrow","REDUCED INEQUALITIES arrow","SUSTAINABLE CITIES AND COMMUNITIES arrow","RESPONSIBLE CONSUMPTION AND PRODUCTION arrow","CLIMATE ACTION arrow","LIFE BELOW WATER arrow","LIFE ON LAND arrow","PEACE, JUSTICE AND STRONG INSTITUTIONS arrow","PARTNERSHIPS FOR THE GOALS arrow"]
    var arrList = [Sdgs_MEBITCat]()
   
    var categorylist = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        footerView.blueFooterViewDelegate = self
        footerView.imgWhatsnew.image = #imageLiteral(resourceName: "Whats New")
        footerView.imgFromDCategory.image = #imageLiteral(resourceName: "Categories_Active")
        self.SDGSCategoryTableView.estimatedRowHeight = 60
        self.SDGSCategoryTableView.rowHeight = UITableView.automaticDimension
        SDGSCategoryTableView?.register(SDGSListTableCell.nib, forCellReuseIdentifier: SDGSListTableCell.identifier)
        SDGSCategoryTableView?.dataSource = self
        SDGSCategoryTableView?.delegate = self
        callWebserviceSDGSCategory()
        // Do any additional setup after loading the view.
    
    }
    
    @IBAction func onClickDismiss(_ sender: UIButton) {
        let mainVC = FlowController().instantiateViewController(identifier: "NavCategory", storyBoard: "Category")
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = mainVC
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3

        UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
        { completed in
            // maybe do something on completion here
        })
        appDel.window?.makeKeyAndVisible()
        
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
extension  SDGSCategoryvc : BlueFooterViewDelegate{
   

    func footerBarAction1(strType: String){
   
        if strType == "WhatsNew"{
            print("Type1")
            

            let vc = FlowController().instantiateViewController(identifier: "SDGSvc", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else if strType == "Categories"{
            print("Type2")
            
            let vc = FlowController().instantiateViewController(identifier: "SDGSCategoryVC", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
        
    }
    
    
    //Apicalling
    func callWebserviceSDGSCategory() {
        APIClient.webserviceForCategoryList { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrDate = result.data{
                        if self.arrList.count>0{
                            self.arrList.removeAll()
                        }
                        if arrDate.maas!.count>0{
                            self.arrList = arrDate.sdgs!
                        }
                    }
                    self.SDGSCategoryTableView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
        
    }

}
extension SDGSCategoryvc: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SDGSListTableCell.identifier, for: indexPath) as? SDGSListTableCell
//        cell?.delegate = self
        //cell!.nameLbl.text = "TEst"
        
        cell!.nameLbl.text = arrList[indexPath.row].lable
      // let imgstr = name["icon"] as! String

        if arrList[indexPath.row].icon != ""{
            let url = BaseURL + arrList[indexPath.row].icon!
            cell!.iconimgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell!.iconimgView.sd_setImage(with: URL.init(string: url), completed: nil)

        }
       // cell!.nameLbl.text = name["lable"] as? String
       // cell!.nameLbl.sizeToFit()
        cell!.addbtn.setImage(UIImage(named: arrowArray[indexPath.row]), for: UIControl.State.normal)
        //cell!.iconimgView.image = UIImage(named: imageArray[indexPath.row])
        
        
        cell!.backView.backgroundColor = UIColor.hexStringToUIColor(hex: arrList[indexPath.row].color!)
        return cell!
    }
}
//MARK: - TableView Delegate Methods
extension SDGSCategoryvc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SDGSListTableCell.identifier, for: indexPath) as? SDGSListTableCell
        cell!.backgroundColor = UIColor.white

        let obj = arrList[indexPath.row]
        
        
        let story = UIStoryboard(name: "Category", bundle:nil)
      //  let obj = arrList[indexPath.row]
        let vc = story.instantiateViewController(withIdentifier: "SDGSListVC") as! SDGSListvc
        vc.idvalue = String(obj.id ?? "0")
        vc.headerImageValue = String(obj.lable ?? "0")
      
        self.navigationController?.pushViewController(vc, animated: true)
        self.SDGSCategoryTableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

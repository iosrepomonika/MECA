//
//  HydrogenVC.swift
//  MECA
//
//  Created by Macbook  on 05/05/21.
//

import UIKit
import SDWebImage
class HydrogenVC: UIViewController {
    @IBOutlet weak var hydrogenBottomview: UIView!
    @IBOutlet weak var hydrogenCategoryCollectionView: UICollectionView!
    @IBOutlet weak var varhydrogenTblView : UITableView!
    var actualController:UIViewController!
    var viewModel : HomeVM!
    var strComeFrom = ""
    var type  = 0
    var arrAllData =  [Datahydrogen]()
    var arrList = [Hydrogen_MEBITCat]()
    var param : [String:Any] = [:]
    var index = 0
    var catID = ""
    var allEvent = ""
    var categorytitle :[String] = []
    
    //new
    @IBOutlet weak var viewFilter: RCustomView!
    @IBOutlet weak var btnEventAscOutlet: UIButton!
    @IBOutlet weak var btnEventDsc: UIButton!
    @IBOutlet weak var btnDateAsc: UIButton!
    @IBOutlet weak var btnDateDsc: UIButton!
    @IBOutlet weak var imgEventACS: UIImageView!
    @IBOutlet weak var imgEventDsc: UIImageView!
    @IBOutlet weak var imgDateAsc: UIImageView!
    @IBOutlet weak var imgDateDsc: UIImageView!
    @IBOutlet weak var txtSearch: UITextField!
    var updatedText = ""
    var sortKey = ""
    var sortOrder = ""
    var currentPage : Int = 1
    var checkPagination = ""
    var isLoadingList : Bool = false
    private var pullControl = UIRefreshControl()
    var sortingArr = [Sorting_options]()
//    var sections:[String] = []
    //filter menu
    
    @IBAction func btnCreateNewAction(_ sender: RCustomButton) {
        categorytitle.remove(at: 0)
        print("categorytitle\(categorytitle)")
//        let vcs = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home")
//        vcs.mytitle = categorytitle
//        self.navigationController?.pushViewController(vcs, animated: true)
        
        let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
     
       // vc.passcategoryvalue = categorytitle

        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.delegate = self
        categorytitle.append("All")
        //callmodulecategory()
        hydrogenCategoryCollectionView.register(MEBITCollectionViewCell.nib(), forCellWithReuseIdentifier: "MEBITCollectionViewCell")
        hydrogenCategoryCollectionView.delegate = self
        hydrogenCategoryCollectionView.dataSource = self
        varhydrogenTblView.register(UINib.init(nibName: "MaasListTVCell", bundle: nil), forCellReuseIdentifier: "MaasListTVCell")
        varhydrogenTblView.delegate = self
        varhydrogenTblView.dataSource = self
        callWebserviceHydrogenCategory()
        checkPagination = "get"
        CallWebserviceHydrogenList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder,catType: "", keyword: updatedText)
        setupUI()
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            varhydrogenTblView.refreshControl = pullControl
        } else {
            varhydrogenTblView.addSubview(pullControl)
        }
        // Do any additional setup after loading the view.
    }
    @objc private func refreshListData(_ sender: Any) {
        checkPagination = "get"
        currentPage = 1
        CallWebserviceHydrogenList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder,catType: "", keyword: updatedText)
        self.pullControl.endRefreshing() // You can stop after API Call

        }
    
    func setupUI()  {
        viewFilter.isHidden = true
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         layout.itemSize = CGSize(width: 90, height: 35)
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 0
        hydrogenCategoryCollectionView!.collectionViewLayout = layout
        hydrogenCategoryCollectionView!.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        layout.scrollDirection = .horizontal
    }
    @IBAction func btnApplyFilter(_ sender: UIButton) {
        if sender.tag == 10{
            viewFilter.isHidden = true
        
            sortKey = sortingArr[0].sortkey ?? ""
            sortOrder = sortingArr[0].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceHydrogenList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder,catType: "", keyword: updatedText)

        }else if sender.tag == 20 {
            viewFilter.isHidden = true
            sortKey = sortingArr[1].sortkey ?? ""
            sortOrder = sortingArr[1].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceHydrogenList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder,catType: "", keyword: updatedText)

        }else if sender.tag == 30 {
            viewFilter.isHidden = true
            sortKey = sortingArr[2].sortkey ?? ""
            sortOrder = sortingArr[2].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceHydrogenList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder,catType: "", keyword: updatedText)

        }else{
            viewFilter.isHidden = true
            sortKey = sortingArr[3].sortkey ?? ""
            sortOrder = sortingArr[3].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceHydrogenList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder,catType: "", keyword: updatedText)

        }
    }
    //hydrogen event call api
    func callWebserviceHydrogenCategory() {
        APIClient.webserviceForCategoryList { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    print("\(result.data)")
                    if let arrDate = result.data{
                        if self.arrList.count>0{
                            self.arrList.removeAll()
                        }
                        if arrDate.hydrogen!.count>0{
                            print("\(String(describing: arrDate.hydrogen))")
                            self.arrList = arrDate.hydrogen!
                        }
                        if self.sortingArr.count>0{
                            self.sortingArr.removeAll()
                        }
                        if arrDate.sorting_options!.count>0{
                            self.sortingArr = arrDate.sorting_options!
                        }
                    }
                    self.hydrogenCategoryCollectionView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
        
        

        
    }
    
    
    
  
    @IBAction func btnBackAction(_ sender: UIButton) {
        viewFilter.isHidden = true
        self.navigationController?.popViewController(animated: true)
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
//MARK:- UICollectionview Delegate Datasource
extension HydrogenVC :  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hydrogenCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MEBITCollectionViewCell", for: indexPath) as! MEBITCollectionViewCell
        cell.baseView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        //cell.titleLabel.adjustsFontSizeToFitWidth = true
        //cell.titleLabel.minimumScaleFactor = 0.5
        if indexPath.row == 0{
            cell.titleLabel.text = "All"
        }else{
            print("\(String(describing: arrList[indexPath.row - 1].lable))")
        cell.titleLabel.text = arrList[indexPath.row - 1].label
        }
        if indexPath.row == index {
            cell.bottomlabel.isHidden = false
            cell.titleLabel.font = UIFont.init(name: "SF Pro Text, Bold", size: 14)

        }else{
            cell.titleLabel.font = UIFont.init(name: "SF Pro Text, Regular", size: 14)
            cell.bottomlabel.isHidden = true

        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        hydrogenCategoryCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        index = indexPath.row
        if indexPath.row == 0{
            catID = ""
        }else{
            catID = arrList[indexPath.row - 1].id ?? ""
            
            print("catID \(catID)")
        }
        CallWebserviceHydrogenList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder,catType: catID, keyword: updatedText)
        hydrogenCategoryCollectionView.reloadData()

        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
            return CGSize(width: 60, height: 35)
        }else{
            return CGSize(width: 100, height: 35)
        }
            
        }
    
    
}
//MARK:- UITableview Delegate Datasource
extension HydrogenVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAllData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MaasListTVCell", for: indexPath) as! MaasListTVCell
        let objFeed = arrAllData[indexPath.row]
        //cell.setCell(feed: objFeed)
        cell.setCellhydrogen(feed: objFeed)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 292
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Category", bundle:nil)
        let obj = arrAllData[indexPath.row]
        let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
        print("String(obj.id ?? 0) Maas \(String(obj.id ?? 0))")
        vc.eventID = String(obj.id ?? 0)
        vc.isEvent = false
        vc.ComingfromVC = "hydrogen"
        vc.Maasview = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
//            if indexPath == lastVisibleIndexPath {
//                if indexPath.row == self.arrAllData.count-1{
//                    self.checkPagination = "pagination"
//                    currentPage += 1
//                    GlobalObj.displayLoader(true, show: true)
//                    GlobalObj.run(after: 2) {
//                        self.CallWebserviceHydrogenList(page: String(self.currentPage), sortkey: self.sortKey, sortorder: self.sortOrder,catType: self.catID,keyword: self.updatedText)                    }
//                }
//            }
//    }
//}
    //Hydrogen api call
    func CallWebserviceHydrogenList(page:String, sortkey:String, sortorder:String,catType: String,keyword:String) {
        
        let param : [String:Any] = ["keyword":keyword,
                                    "type":catID,
                                    "sortkey":sortkey,
                                    "sortorder":sortorder]
       // let param : [String:Any] = ["is_admin" : adminId,
                                  //  "type" : type]//"keyword" : "test"
        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForHydrogen(limit: "10",page: page, params: param) { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    if self.checkPagination == "get"{
                        self.arrAllData.removeAll()
                    }
                    if let arrDate = result.data{
                        if self.arrAllData.count>0{
                            self.arrAllData.removeAll()
                        }
                        if arrDate.count == 0{
                            return
                        }
                        
                        for obj in arrDate {
                            self.arrAllData.append(obj)
                        }
                        
                    }
                    self.varhydrogenTblView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
        
        
    }
    
    
//    func callmodulecategory()     {
//        GlobalObj.displayLoader(true, show: true)
//        APIClient.webServicesForModeulecategory(params: [:]) { (response) in
//            print(response)
//            if let dict = response as? [String:Any]{
//                if let categoryvalue = dict["data"] as? [String:Any]{
//                    if let labeltxt = categoryvalue["maas"] as? [Any] {
//                        for (_, ship) in labeltxt.enumerated() {
//                            if let array = ship as? [String: Any] {
//                                //If you want array of task id you can try like
//                                let categoryname = array["lable"] as? String
//                                print("categoryname\(categoryname!)")
//                                self.categorytitle.append(categoryname!)
//                            }
//                        }
//                        self.segControlFromNib!.sectionTitles = self.categorytitle
////                        let strArray = self.getString(array: self.categorytitle)
////                                print(strArray)
////                        self.sgTextOnlyBar.buttonTitles = strArray
//                        print("categorytitle\(self.categorytitle)")
//                    }
//                }
//            }
//
//
//            GlobalObj.displayLoader(true, show: false)
//        }
//    }

}
extension HydrogenVC{
    @IBAction func filterationBtnAction(_ sender: UIButton) {
        for i in 0..<sortingArr.count {
            let objSorting = sortingArr[i]
            if i == 0 {
                btnEventAscOutlet.setTitle(objSorting.lable, for: .normal)
                if let img = objSorting.icon{
                    let imgUrl = BaseURL + img
                    
                    imgEventACS.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    imgEventACS.sd_setImage(with: URL(string: imgUrl), completed: nil)
                }
               
                
            }else if i == 1{
                btnEventDsc.setTitle(objSorting.lable, for: .normal)
                if let img = objSorting.icon{
                    let imgUrl = BaseURL + img
                    imgEventDsc.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    imgEventDsc.sd_setImage(with: URL(string: imgUrl), completed: nil)
                }
            }else if i == 2{
                btnDateAsc.setTitle(objSorting.lable, for: .normal)
                if let img = objSorting.icon{
                    let imgUrl = BaseURL + img
                    imgDateAsc.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    imgDateAsc.sd_setImage(with: URL(string: imgUrl), completed: nil)
                }
            }else if i == 3{
                btnDateDsc.setTitle(objSorting.lable, for: .normal)
                if let img = objSorting.icon{
                    let imgUrl = BaseURL + img
                    imgDateDsc.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    imgDateDsc.sd_setImage(with: URL(string: imgUrl), completed: nil)
                }
            }
        }
        viewFilter.isHidden = false
    }
}
//MARK:- Textfeild delegate
extension HydrogenVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
                   let textRange = Range(range, in: text) {
            updatedText = text.replacingCharacters(in: textRange,with: string)
            currentPage = 1
           //GlobalObj.displayLoader(true, show: false)

            if text.count > 3 {
                checkPagination = "get"

                CallWebserviceHydrogenList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder,catType: catID, keyword: updatedText)

            }
        }
        return true
    }
}

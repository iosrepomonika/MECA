//
//  MaasViewController.swift
//  MECA
//
//  Created by Macbook  on 13/04/21.SDGSvc
//

import UIKit
import SDWebImage
class MaasViewController: UIViewController {
    
    
    @IBOutlet weak var MaasBottomview: UIView!
    @IBOutlet weak var MaasCategoryCollectionView: UICollectionView!
    @IBOutlet weak var varNewCarSaleTblView : UITableView!
    @IBOutlet weak var txtMaassearchbar : UITextField!
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var btnEventAscOutlet: UIButton!
    @IBOutlet weak var btnEventDsc: UIButton!
    @IBOutlet weak var btnDateAsc: UIButton!
    @IBOutlet weak var btnDateDsc: UIButton!
    @IBOutlet weak var imgEventACS: UIImageView!
    @IBOutlet weak var imgEventDsc: UIImageView!
    @IBOutlet weak var imgDateAsc: UIImageView!
    @IBOutlet weak var imgDateDsc: UIImageView!
    private var pullControl = UIRefreshControl()

    var actualController:UIViewController!
    var viewModel : HomeVM!
    var strComeFrom = ""
    var type  = 0
    var arrAllData =  [DataMaas]()
    var arrList = [Maas_MEBITCat]()
    var sortingArr = [Sorting_options]()
    var param : [String:Any] = [:]
    var index = 0
    var catID = ""
    var allEvent = ""
    var categorytitle :[String] = []
    var sortKey = ""
    var sortOrder = ""
    var currentPage : Int = 1
    var checkPagination = ""
    var updatedText = ""
    var isFromCat = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.barTintColor = UIColor.red
        searchController.searchBar.tintColor = UIColor.white
        categorytitle.append("All")
        //callmodulecategory()
        MaasCategoryCollectionView.register(MEBITCollectionViewCell.nib(), forCellWithReuseIdentifier: "MEBITCollectionViewCell")
        MaasCategoryCollectionView.delegate = self
        MaasCategoryCollectionView.dataSource = self
        varNewCarSaleTblView.register(UINib.init(nibName: "MaasListTVCell", bundle: nil), forCellReuseIdentifier: "MaasListTVCell")
        varNewCarSaleTblView.delegate = self
        varNewCarSaleTblView.dataSource = self
        callWebserviceEventCategory()
        CallWebserviceMaasList(sortkey: sortKey, sortorder: sortOrder)
        viewFilter.isHidden = true
        txtMaassearchbar.delegate = self
       
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            varNewCarSaleTblView.refreshControl = pullControl
        } else {
            varNewCarSaleTblView.addSubview(pullControl)
        }
     
        setupUI()
    }
    @objc private func refreshListData(_ sender: Any) {
        self.pullControl.endRefreshing()
        currentPage = 1
        self.checkPagination = "get"
        CallWebserviceMaasList(sortkey: sortKey, sortorder: sortOrder)
    }
    
    func setupUI()  {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         layout.itemSize = CGSize(width: 90, height: 35)
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 0
        MaasCategoryCollectionView!.collectionViewLayout = layout
        MaasCategoryCollectionView!.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        layout.scrollDirection = .horizontal
    }
    func getString(array : [String]) -> String {
            let stringArray = array.map{ String($0) }
            return stringArray.joined(separator: ",")
        }
    
    func callWebserviceEventCategory() {
        APIClient.webserviceForCategoryList { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrDate = result.data{
                        if self.arrList.count>0{
                            self.arrList.removeAll()
                        }
                        if arrDate.maas!.count>0{
                            self.arrList = arrDate.maas!
                        }
                        
                        if self.sortingArr.count>0{
                            self.sortingArr.removeAll()
                        }
                        if arrDate.sorting_options!.count>0{
                            self.sortingArr = arrDate.sorting_options!
                        }
                    }
                    self.MaasCategoryCollectionView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
        
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func btnApplyFilterActon(_ sender: UIButton) {
        if sender.tag == 10{
            viewFilter.isHidden = true
        
            sortKey = sortingArr[0].sortkey ?? ""
            sortOrder = sortingArr[0].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceMaasList(sortkey: sortKey, sortorder: sortOrder)

        }else if sender.tag == 20 {
            viewFilter.isHidden = true
            sortKey = sortingArr[1].sortkey ?? ""
            sortOrder = sortingArr[1].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceMaasList(sortkey: sortKey, sortorder: sortOrder)

        }else if sender.tag == 30 {
            viewFilter.isHidden = true
            sortKey = sortingArr[2].sortkey ?? ""
            sortOrder = sortingArr[2].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceMaasList(sortkey: sortKey, sortorder: sortOrder)

        }else{
            viewFilter.isHidden = true
            sortKey = sortingArr[3].sortkey ?? ""
            sortOrder = sortingArr[3].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceMaasList(sortkey: sortKey, sortorder: sortOrder)

        }
    }
    @IBAction func btnFilterAction(_ sender: UIButton) {
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
    
    @IBAction func btnCreateNewAction(_ sender: RCustomButton) {
        categorytitle.remove(at: 0)
        print("categorytitle\(categorytitle)")
    
        let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK:- UICollectionview Delegate Datasource
extension MaasViewController :  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MaasCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MEBITCollectionViewCell", for: indexPath) as! MEBITCollectionViewCell
        cell.baseView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        if indexPath.row == 0{
            cell.titleLabel.text = "All"
        }else{
        cell.titleLabel.text = arrList[indexPath.row - 1].lable
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

        MaasCategoryCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        index = indexPath.row
        if indexPath.row == 0{
            catID = ""
        }else{
            catID = arrList[indexPath.row - 1].id ?? ""
            
            print("catID \(catID)")
        }
        self.isFromCat = true
        currentPage = 1
        CallWebserviceMaasList(sortkey: sortKey, sortorder: sortOrder)
        MaasCategoryCollectionView.reloadData()

        
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
extension MaasViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAllData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MaasListTVCell", for: indexPath) as! MaasListTVCell
        let objFeed = arrAllData[indexPath.row]
        //cell.setCell(feed: objFeed)
        cell.setCellNewCar(feed: objFeed)
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
       // vc.ComingfromVC = "Maas"
        vc.Maasview = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                if indexPath.row == arrAllData.count-1{
                    self.checkPagination = "pagination"
                    currentPage += 1
                    GlobalObj.run(after: 2) {
                        GlobalObj.displayLoader(true, show: true)
                        self.CallWebserviceMaasList(sortkey: self.sortKey, sortorder: self.sortOrder)
                    }
                }
            }
        }
    }
    func CallWebserviceMaasList(sortkey: String, sortorder: String) {
        if catID == "1" {
            param = [ "type" : catID,
                      "keyword" : updatedText,
                      "sortkey" : sortkey,
                      "sortorder" : sortorder]
        }else if catID == "2"{
            param = [ "type" : catID,
                      "keyword" : updatedText,
                      "sortkey" : sortkey,
                      "sortorder" : sortorder]
        }else if type == 0 {
            param = ["keyword" : updatedText,
                      "sortkey" : sortkey,
                      "sortorder" : sortorder]
        }

        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForMaas(limit: "10", page: String(currentPage), params: param) { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrDate = result.data{
                        if self.checkPagination == "get"{
                            self.arrAllData.removeAll()
                        }
                        for obj in arrDate {
                            self.arrAllData.append(obj)
                        }
                        if self.isFromCat{
                            self.isFromCat = false
                        }else{
                            if arrDate.count == 0 {
                                GlobalObj.displayLoader(true, show: false)
                                return
                            }
                        }
                    }
                    if self.arrAllData.count == 0{
                        self.varNewCarSaleTblView.isHidden = true
                    }else{
                        self.varNewCarSaleTblView.isHidden = false
                    }
                    self.varNewCarSaleTblView.reloadData()
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

//MARK:- Textfeild delegate
extension MaasViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
                   let textRange = Range(range, in: text) {
            updatedText = text.replacingCharacters(in: textRange,with: string)
            currentPage = 1
            self.checkPagination = "get"
            CallWebserviceMaasList(sortkey: sortKey, sortorder: sortOrder)

        }
        return true
    }
}

//
//  MEBITEventVC.swift
//  MECA
//
//
//

import UIKit
import SDWebImage

class MEBITEventVC: UIViewController{
    
    
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: RCustomView!
    @IBOutlet weak var filterationBtnRef: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var EventsBtnRef: UIButton!
    @IBOutlet weak var upcomingBtnRef: UIButton!
    @IBOutlet weak var pastBtnRef: UIButton!
    @IBOutlet weak var MebitTblView: UITableView!
    @IBOutlet weak var viewFilter: RCustomView!
    @IBOutlet weak var btnEventAscOutlet: UIButton!
    @IBOutlet weak var btnEventDsc: UIButton!
    @IBOutlet weak var btnDateAsc: UIButton!
    @IBOutlet weak var btnDateDsc: UIButton!
    @IBOutlet weak var imgEventACS: UIImageView!
    @IBOutlet weak var imgEventDsc: UIImageView!
    @IBOutlet weak var imgDateAsc: UIImageView!
    @IBOutlet weak var imgDateDsc: UIImageView!
    
    
    var categoryArr = [Event_MEBITCat]()
    var sortingArr = [Sorting_options]()
    
    var arrAllData = [Data_CatList]()
    
    private var pullControl = UIRefreshControl()

    var catID = ""
    var allEvent = ""
    var updatedText = ""
    var sortKey = ""
    var sortOrder = ""
    var currentPage : Int = 1
    var checkPagination = ""
    var isLoadingList : Bool = false
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        CategoryCollectionView.register(MEBITCollectionViewCell.nib(), forCellWithReuseIdentifier: "MEBITCollectionViewCell")
        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
        MebitTblView.register(MEBITEventTableViewCell.nib(), forCellReuseIdentifier: "MEBITEventTableViewCell")
        MebitTblView.delegate = self
        MebitTblView.dataSource = self
        callWebserviceEventCategory()
        checkPagination = "get"
        CallWebserviceEventList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder)
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            MebitTblView.refreshControl = pullControl
        } else {
            MebitTblView.addSubview(pullControl)
        }
    }
    @objc private func refreshListData(_ sender: Any) {
        checkPagination = "get"
        currentPage = 1
        CallWebserviceEventList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder)
        self.pullControl.endRefreshing() // You can stop after API Call

        }
    func setupUI() {
        viewFilter.isHidden = true
        filterationBtnRef.layer.cornerRadius = 8
        upcomingBtnRef.layer.cornerRadius = 12
        EventsBtnRef.layer.cornerRadius = 12
        pastBtnRef.layer.cornerRadius = 12
        EventsBtnRef.backgroundColor = #colorLiteral(red: 0.9617725015, green: 0.4417187572, blue: 0.2027035654, alpha: 1)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 35)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        CategoryCollectionView!.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
    }
    
   
    
    func callWebserviceEventCategory() {
        APIClient.webserviceForCategoryList { (result) in
            
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    
                    if let arrDate = result.data{
                        print(arrDate)
                        if self.categoryArr.count>0{
                            self.categoryArr.removeAll()
                        }
                        if arrDate.event!.count>0{
                            self.categoryArr = arrDate.event!
                        }
                        
                        if self.sortingArr.count>0{
                            self.sortingArr.removeAll()
                        }
                        if arrDate.sorting_options!.count>0{
                            self.sortingArr = arrDate.sorting_options!
                        }
                    }
                    self.CategoryCollectionView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)
                    
                }
            }
            
            GlobalObj.displayLoader(true, show: false)
            
        }
        
    }
    func CallWebserviceEventList(page:String, sortkey:String, sortorder:String) {
        GlobalObj.displayLoader(true, show: true)
        
        let param : [String:Any] = ["status":allEvent,
                                    "category":catID,
                                    "keyword":updatedText,
                                    "sortkey":sortkey,
                                    "sortorder":sortorder]
        print(param)
        APIClient.webserviceForCategory(limit: "10",page: page, params: param) { (result) in
            
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    if self.checkPagination == "get"{
                        self.arrAllData.removeAll()
                    }
                    if let arrDate = result.data{
                        print(arrDate)
                        if arrDate.count == 0{
                            return
                        }
                        
                        for obj in arrDate {
                            self.arrAllData.append(obj)
                        }
                        
                    }
                    self.MebitTblView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)
                    
                }
            }
            
            GlobalObj.displayLoader(true, show: false)
            
        }
    }
}
//MARK:- UIButton Action
extension MEBITEventVC{
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
    
    @IBAction func DismissBtnAction(_ sender: UIButton) {
        viewFilter.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventBtnAction(_ sender: UIButton) {
        viewFilter.isHidden = true
        EventsBtnRef.backgroundColor = #colorLiteral(red: 0.9617725015, green: 0.4417187572, blue: 0.2027035654, alpha: 1)
        pastBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        upcomingBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        allEvent = ""
        checkPagination = "get"
        currentPage = 1
        CallWebserviceEventList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder)
        
    }
    @IBAction func upcomingBtnAction(_ sender: UIButton) {
        viewFilter.isHidden = true
        EventsBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        pastBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        upcomingBtnRef.backgroundColor = #colorLiteral(red: 0.9617725015, green: 0.4417187572, blue: 0.2027035654, alpha: 1)
        allEvent = "2"
        checkPagination = "get"
        currentPage = 1
        CallWebserviceEventList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder)
    }
    
    @IBAction func pastBtnAction(_ sender: UIButton) {
        viewFilter.isHidden = true
        EventsBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        pastBtnRef.backgroundColor = #colorLiteral(red: 0.9617725015, green: 0.4417187572, blue: 0.2027035654, alpha: 1)
        upcomingBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        allEvent = "1"
        checkPagination = "get"
        currentPage = 1
        CallWebserviceEventList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder)
    }
    @IBAction func btnApplyFilter(_ sender: UIButton) {
        if sender.tag == 10{
            viewFilter.isHidden = true
        
            sortKey = sortingArr[0].sortkey ?? ""
            sortOrder = sortingArr[0].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceEventList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder)

        }else if sender.tag == 20 {
            viewFilter.isHidden = true
            sortKey = sortingArr[1].sortkey ?? ""
            sortOrder = sortingArr[1].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceEventList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder)

        }else if sender.tag == 30 {
            viewFilter.isHidden = true
            sortKey = sortingArr[2].sortkey ?? ""
            sortOrder = sortingArr[2].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceEventList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder)

        }else{
            viewFilter.isHidden = true
            sortKey = sortingArr[3].sortkey ?? ""
            sortOrder = sortingArr[3].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceEventList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder)

        }
    }
}
extension MEBITEventVC :  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MEBITCollectionViewCell", for: indexPath) as! MEBITCollectionViewCell
        cell.baseView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        if indexPath.row == 0{
            cell.titleLabel.text = "All"
        }else{
        cell.titleLabel.text = categoryArr[indexPath.row - 1].lable
        }
        if indexPath.row == index {
            cell.bottomlabel.isHidden = false
            cell.titleLabel.font = UIFont.init(name: "SF-Pro-Text-Bold", size: 14)

        }else{
            cell.titleLabel.font = UIFont.init(name: "SF Pro Text, Regular", size: 14)
            cell.bottomlabel.isHidden = true

        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        CategoryCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        index = indexPath.row
        if indexPath.row == 0{
            catID = ""
        }else{
            catID = categoryArr[indexPath.row - 1].id ?? ""
            
            
        }
        checkPagination = "get"
        currentPage = 1
        CallWebserviceEventList(page: String(currentPage), sortkey: sortKey, sortorder: sortOrder)
        CategoryCollectionView.reloadData()

        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
            return CGSize(width: 60, height: 35)
        }else{
            return CGSize(width: 100, height: 35)
        }
            
        }
    
    
}
extension MEBITEventVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAllData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MebitTblView.dequeueReusableCell(withIdentifier: "MEBITEventTableViewCell", for: indexPath) as! MEBITEventTableViewCell
        cell.mebitTitlelbl.text = arrAllData[indexPath.row].title
        cell.mebitDatelbl.text = arrAllData[indexPath.row].created_at
        if arrAllData[indexPath.row].cover_image != ""{
            let url = BaseURL + arrAllData[indexPath.row].cover_image!
            cell.MebitImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.MebitImage.sd_setImage(with: URL.init(string: url), completed: nil)

        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Category", bundle:nil)
        let obj = arrAllData[indexPath.row]
        let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
        vc.eventID = String(obj.id ?? 0)
        vc.isEvent = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                if indexPath.row == self.arrAllData.count-1{
                    self.checkPagination = "pagination"
                    currentPage += 1
                    GlobalObj.displayLoader(true, show: true)
                    GlobalObj.run(after: 2) {
                        self.CallWebserviceEventList(page: String(self.currentPage), sortkey: self.sortKey, sortorder: self.sortOrder)                    }
                }
            }
    }
}

}


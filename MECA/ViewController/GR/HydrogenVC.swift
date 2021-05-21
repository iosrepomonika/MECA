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
    @IBOutlet weak var btnEventAscOutlet: UIButton!
    @IBOutlet weak var btnEventDsc: UIButton!
    @IBOutlet weak var btnDateAsc: UIButton!
    @IBOutlet weak var btnDateDsc: UIButton!
    @IBOutlet weak var imgEventACS: UIImageView!
    @IBOutlet weak var imgEventDsc: UIImageView!
    @IBOutlet weak var imgDateAsc: UIImageView!
    @IBOutlet weak var imgDateDsc: UIImageView!
    @IBOutlet weak var viewFilter: UIView!
    
    
    private var pullControl = UIRefreshControl()
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
    var sortKey = ""
    var sortOrder = ""
    var currentPage : Int = 1
    var checkPagination = ""
    var updatedText = ""
    var sortingArr = [Sorting_options]()

    var isFromCat = false
    
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
        categorytitle.append("All")
        //callmodulecategory()
        viewFilter.isHidden = true
        hydrogenCategoryCollectionView.register(MEBITCollectionViewCell.nib(), forCellWithReuseIdentifier: "MEBITCollectionViewCell")
        hydrogenCategoryCollectionView.delegate = self
        hydrogenCategoryCollectionView.dataSource = self
        varhydrogenTblView.register(UINib.init(nibName: "MaasListTVCell", bundle: nil), forCellReuseIdentifier: "MaasListTVCell")
        varhydrogenTblView.delegate = self
        varhydrogenTblView.dataSource = self
        callWebserviceHydrogenCategory()
        CallWebserviceHydrogenList(strType: "", sortkey: sortKey, sortorder: sortOrder)
       
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            varhydrogenTblView.refreshControl = pullControl
        } else {
            varhydrogenTblView.addSubview(pullControl)
        }

        setupUI()
        // Do any additional setup after loading the view.
    }
    @objc private func refreshListData(_ sender: Any) {
        self.pullControl.endRefreshing()
        currentPage = 1
        self.checkPagination = "get"
        CallWebserviceHydrogenList(strType: "", sortkey: sortKey, sortorder: sortOrder)
    }
    
    func setupUI()  {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         layout.itemSize = CGSize(width: 90, height: 35)
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 0
        hydrogenCategoryCollectionView!.collectionViewLayout = layout
        hydrogenCategoryCollectionView!.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        layout.scrollDirection = .horizontal
    }
    //hydrogen event call api
    func callWebserviceHydrogenCategory() {
        APIClient.webserviceForCategoryList { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    print("\(String(describing: result.data))")
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
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func btnApplyFilter(_ sender: UIButton)
    {
        if sender.tag == 10{
            viewFilter.isHidden = true

            sortKey = sortingArr[0].sortkey ?? ""
            sortOrder = sortingArr[0].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceHydrogenList(strType: catID, sortkey: sortKey, sortorder: sortOrder)
        }else if sender.tag == 20 {
            viewFilter.isHidden = true
            sortKey = sortingArr[1].sortkey ?? ""
            sortOrder = sortingArr[1].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceHydrogenList(strType: catID, sortkey: sortKey, sortorder: sortOrder)

        }else if sender.tag == 30 {
            viewFilter.isHidden = true
            sortKey = sortingArr[2].sortkey ?? ""
            sortOrder = sortingArr[2].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceHydrogenList(strType: catID, sortkey: sortKey, sortorder: sortOrder)

        }else{
            viewFilter.isHidden = true
            sortKey = sortingArr[3].sortkey ?? ""
            sortOrder = sortingArr[3].sortorder ?? ""
            checkPagination = "get"
            currentPage = 1
            CallWebserviceHydrogenList(strType: catID, sortkey: sortKey, sortorder: sortOrder)

        }
    }
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
        self.checkPagination = "get"
        isFromCat = true
        if indexPath.row == 0{
            CallWebserviceHydrogenList(strType: "", sortkey: sortKey, sortorder: sortOrder)

        }else{
            CallWebserviceHydrogenList(strType: catID, sortkey: sortKey, sortorder: sortOrder)

        }
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
        print(obj.type)
        vc.eventID = String(obj.id ?? 0)
        vc.isEvent = false
        vc.module = "hydrogen"
        vc.ComingfromVC = "hydrogen"
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
                        self.CallWebserviceHydrogenList(strType: "", sortkey: self.sortKey, sortorder: self.sortOrder)                   }
                }
            }
        }
    }
    //Hydrogen api call
    func CallWebserviceHydrogenList(strType: String,sortkey: String, sortorder: String) {

        param = [ "type" : catID,
                  "keyword" : updatedText,
                  "sortkey" : sortkey,
                  "sortorder" : sortorder]
        print("param\(param)")
        //param["keyword": "", "type": "", "sortorder": "", "sortkey": ""]

        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForHydrogen(limit:"10", page: String(currentPage), params: param) { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    if self.checkPagination == "get"{
                        self.arrAllData.removeAll()
                    }
                    if let arrDate = result.data{
                        if self.isFromCat == false{
                            if arrDate.count == 0 {
                                GlobalObj.displayLoader(true, show: false)
                                return
                            }
                        }else{
                            self.isFromCat = false
                        }
                        for obj in arrDate {
                            self.arrAllData.append(obj)
                        }
                    }
                    if self.arrAllData.count>0{
                        self.varhydrogenTblView.isHidden = false
                    }else{
                        self.varhydrogenTblView.isHidden = true
                    }
                    self.varhydrogenTblView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
        
    }

}

//MARK:- Textfeild delegate
extension HydrogenVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
                   let textRange = Range(range, in: text) {
            updatedText = text.replacingCharacters(in: textRange,with: string)
            currentPage = 1
            self.checkPagination = "get"
            CallWebserviceHydrogenList(strType: catID, sortkey: sortKey, sortorder: sortOrder)
        }
        return true
    }
}

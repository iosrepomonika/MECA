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
    var categoryArr = [Event_MEBITCat]()
    var arrAllData = [Data_CatList]()
    
    var catID = ""
    var allEvent = ""
    
    
    
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
        CallWebserviceEventList()
    }
    func setupUI() {
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
    
    @IBAction func filterationBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func DismissBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventBtnAction(_ sender: UIButton) {
        EventsBtnRef.backgroundColor = #colorLiteral(red: 0.9617725015, green: 0.4417187572, blue: 0.2027035654, alpha: 1)
        pastBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        upcomingBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        allEvent = ""
        CallWebserviceEventList()

        
    }
    @IBAction func upcomingBtnAction(_ sender: UIButton) {
        EventsBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        pastBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        upcomingBtnRef.backgroundColor = #colorLiteral(red: 0.9617725015, green: 0.4417187572, blue: 0.2027035654, alpha: 1)
        allEvent = "2"
        CallWebserviceEventList()

    }
    
    @IBAction func pastBtnAction(_ sender: UIButton) {
        EventsBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        pastBtnRef.backgroundColor = #colorLiteral(red: 0.9617725015, green: 0.4417187572, blue: 0.2027035654, alpha: 1)
        upcomingBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        allEvent = "1"
        CallWebserviceEventList()

    }
    
    func callWebserviceEventCategory() {
        APIClient.webserviceForCategoryList { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrDate = result.data{
                        if self.categoryArr.count>0{
                            self.categoryArr.removeAll()
                        }
                        if arrDate.event!.count>0{
                            self.categoryArr = arrDate.event!
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
    func CallWebserviceEventList() {
        GlobalObj.displayLoader(true, show: true)

        let param : [String:Any] = ["status":allEvent,
                                    "category":catID]
        print(param)
        APIClient.webserviceForCategory(params: param) { (result) in
            
            if let respCode = result.resp_code{
             
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let arrDate = result.data{
                        if self.arrAllData.count>0{
                            self.arrAllData.removeAll()
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
            cell.titleLabel.font = UIFont.init(name: "SF Pro Text, Bold", size: 14)

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
        CallWebserviceEventList()
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
    
}

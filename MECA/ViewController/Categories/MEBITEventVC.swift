//
//  MEBITEventVC.swift
//  MECA
//
//
//

import UIKit

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
    let categoryArr = ["All","TBP","WorkShop","Seminar","HR","Others"]
    
    
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
        
    }
    @IBAction func upcomingBtnAction(_ sender: UIButton) {
        EventsBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        pastBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        upcomingBtnRef.backgroundColor = #colorLiteral(red: 0.9617725015, green: 0.4417187572, blue: 0.2027035654, alpha: 1)
    }
    
    @IBAction func pastBtnAction(_ sender: UIButton) {
        EventsBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        pastBtnRef.backgroundColor = #colorLiteral(red: 0.9617725015, green: 0.4417187572, blue: 0.2027035654, alpha: 1)
        upcomingBtnRef.backgroundColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
    }
    
    
    
    
    
    
}
extension MEBITEventVC :  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MEBITCollectionViewCell", for: indexPath) as! MEBITCollectionViewCell
        cell.baseView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        cell.titleLabel.text = categoryArr[indexPath.row]
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
        CategoryCollectionView.reloadData()

        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height: 35)
        }
    
    
}
extension MEBITEventVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MebitTblView.dequeueReusableCell(withIdentifier: "MEBITEventTableViewCell", for: indexPath) as! MEBITEventTableViewCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
}

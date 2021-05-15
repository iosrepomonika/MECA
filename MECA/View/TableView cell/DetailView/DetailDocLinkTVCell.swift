

import UIKit

class DetailDocLinkTVCell: UITableViewCell {
    @IBOutlet weak var tblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    var arrDocumentLink = [Document_links]()
    var arrGRDocumentLink = [GRDocument_links]()
    var isFromGR = false
    var detailVC : NewDetailVC!
    
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var btnSeeMoreHightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    static func nib() -> UINib {
        return UINib(nibName: "DetailDocLinkTVCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setEventData(dataEvent:Data_Event) {
        isFromGR = false
        tblHeightConstraint.constant = 0

    }
    
    func setKaizenData(dataKaizen:KaizenInfoDataModel) {
        isFromGR = false
        if dataKaizen.document_links!.count > 0 {
//            arrDocumentLink.count > 0; do {
               self.arrDocumentLink.removeAll()
//            }
            arrDocumentLink = dataKaizen.document_links!
            
            if arrDocumentLink.count > 3{
                btnSeeMoreHightConstraint.constant = 30
                btnSeeMoreOutlet.isHidden = false
               btnSeeMoreOutlet.addTarget(self, action: #selector(self.SeeMoreAction), for: .touchUpInside)
                tblHeightConstraint.constant = CGFloat(40 * 3)

            }else{
                btnSeeMoreHightConstraint.constant = 0
                btnSeeMoreOutlet.isHidden = true
                tblHeightConstraint.constant = CGFloat(40*arrDocumentLink.count)
            }
            
            tblDocument.register(DetailDocumentLinkTVCell.nib(), forCellReuseIdentifier: "DetailDocumentLinkTVCell")
            tblDocument.delegate = self
            tblDocument.dataSource = self
           // tblHeightConstraint.constant = CGFloat(40*arrDocumentLink.count)
            tblDocument.reloadData()
            detailVC.tblDetailView.beginUpdates()
            detailVC.tblDetailView.endUpdates()
           
        }
    
    }
    
    func setGRData(grData:GRDetail_Data){
        isFromGR = true
        if grData.document_links!.count > 0 {

               self.arrGRDocumentLink.removeAll()

            arrGRDocumentLink = grData.document_links!
            
            if arrGRDocumentLink.count > 3{
                btnSeeMoreHightConstraint.constant = 30
                btnSeeMoreOutlet.isHidden = false
               btnSeeMoreOutlet.addTarget(self, action: #selector(self.SeeMoreAction), for: .touchUpInside)
                tblHeightConstraint.constant = CGFloat(40 * 3)

            }else{
                btnSeeMoreHightConstraint.constant = 0
                btnSeeMoreOutlet.isHidden = true
                tblHeightConstraint.constant = CGFloat(40*arrGRDocumentLink.count)
            }
            
            tblDocument.register(DetailDocumentLinkTVCell.nib(), forCellReuseIdentifier: "DetailDocumentLinkTVCell")
            tblDocument.delegate = self
            tblDocument.dataSource = self
          //  tblHeightConstraint.constant = CGFloat(40*arrGRDocumentLink.count)
           tblDocument.reloadData()
            detailVC.tblDetailView.beginUpdates()
            detailVC.tblDetailView.endUpdates()
           
        }
    
    }
    @objc func SeeMoreAction(sender: UIButton){
        if sender.isSelected{
            sender.isSelected = false
            sender.setTitle("See More", for: .normal)
            tblHeightConstraint.constant = CGFloat(43 * 3)
            tblDocument.reloadData()
            detailVC.tblDetailView.beginUpdates()
            detailVC.tblDetailView.endUpdates()
        }else {
            sender.isSelected = true
            sender.setTitle("Less", for: .normal)
            if GlobalValue.tabCategory == "GR"{
                tblHeightConstraint.constant = CGFloat(43 * arrGRDocumentLink.count)

            }else{
                tblHeightConstraint.constant = CGFloat(43 * arrDocumentLink.count)

            }
            tblDocument.reloadData()
            detailVC.tblDetailView.beginUpdates()
            detailVC.tblDetailView.endUpdates()
            
        }
    }
}
extension DetailDocLinkTVCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFromGR{
            return arrGRDocumentLink.count
        }else{
        return arrDocumentLink.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDocument.dequeueReusableCell(withIdentifier: "DetailDocumentLinkTVCell", for: indexPath) as! DetailDocumentLinkTVCell
        if isFromGR{
            cell.lblDocumentLink.text = arrGRDocumentLink[indexPath.row].link

        }else{
        cell.lblDocumentLink.text = arrDocumentLink[indexPath.row].link
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFromGR{
            let objLink = arrGRDocumentLink[indexPath.row].link ?? ""

            guard let url = URL(string: objLink) else { return }
            UIApplication.shared.open(url)
        }else{
            let objLink = arrDocumentLink[indexPath.row].link ?? ""

            guard let url = URL(string: objLink) else { return }
            UIApplication.shared.open(url)        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}

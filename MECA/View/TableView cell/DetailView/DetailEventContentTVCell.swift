
import UIKit

class DetailEventContentTVCell: UITableViewCell {
    
    @IBOutlet weak var tblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSeeMoreOutlet: UIButton!
    @IBOutlet weak var seeMoreHeightConstraint: NSLayoutConstraint!
    
    var arrEventDocument = [Event_documents]()
    
    var detailVC : NewDetailVC!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if GlobalValue.tabCategory == "GR"{
            btnSeeMoreOutlet.setTitleColor(UIColor.getCustomRedColor(), for: .normal)
        }else if  GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            btnSeeMoreOutlet.setTitleColor(UIColor.getCustomBlueColor(), for: .normal)
        }else{
            btnSeeMoreOutlet.setTitleColor(UIColor.getCustomOrangeColor(), for: .normal)
        }
        seeMoreHeightConstraint.constant = 0
        btnSeeMoreOutlet.isHidden = true
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "DetailEventContentTVCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setEventData(dataEvent:Data_Event) {
        
        if dataEvent.event_documents?.count == 0{
            tblHeightConstraint.constant = 0
        }else{
            if dataEvent.event_documents!.count > 0 {
                arrEventDocument.removeAll()
            }
            arrEventDocument = dataEvent.event_documents!
            if arrEventDocument.count > 3{
                seeMoreHeightConstraint.constant = 30
                btnSeeMoreOutlet.isHidden = false
               btnSeeMoreOutlet.addTarget(self, action: #selector(self.SeeMoreAction), for: .touchUpInside)
                tblHeightConstraint.constant = CGFloat(43 * 3)

            }else{
                seeMoreHeightConstraint.constant = 0
                btnSeeMoreOutlet.isHidden = true
                tblHeightConstraint.constant = CGFloat(43 * dataEvent.event_documents!.count)

            }
           

        tblDocument.register(DocumentContentCell.nib(), forCellReuseIdentifier: "DocumentContentCell")
        tblDocument.delegate = self
        tblDocument.dataSource = self
        tblDocument.reloadData()
        detailVC.tblDetailView.beginUpdates()
        detailVC.tblDetailView.endUpdates()
        }
    }
    func setKaizenData(dataKaizen:KaizenInfoDataModel) {
       // if dataKaizen.kaizen_documents?.count == 0{
            tblHeightConstraint.constant = 0

//        }else{
//            if dataKaizen.kaizen_documents!.count > 0 {
//                arrEventDocument.removeAll()
//            }
//            print(dataKaizen.kaizen_documents?.count)
//            arrEventDocument = dataKaizen.kaizen_documents!
//        tblDocument.register(DocumentContentCell.nib(), forCellReuseIdentifier: "DocumentContentCell")
//        tblDocument.delegate = self
//        tblDocument.dataSource = self
//        tblDocument.reloadData()
//        tblHeightConstraint.constant = CGFloat(43 * dataKaizen.kaizen_documents!.count)
//        }
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
            tblHeightConstraint.constant = CGFloat(43 * arrEventDocument.count)
            tblDocument.reloadData()
            detailVC.tblDetailView.beginUpdates()
            detailVC.tblDetailView.endUpdates()

        }

    }
    func setGRData(grData:GRDetail_Data){
        if grData.event_documents?.count == 0{
            tblHeightConstraint.constant = 0
        }else{
            if grData.event_documents!.count > 0 {
                arrEventDocument.removeAll()
            }
            arrEventDocument = grData.event_documents!
        tblDocument.register(DocumentContentCell.nib(), forCellReuseIdentifier: "DocumentContentCell")
        tblDocument.delegate = self
        tblDocument.dataSource = self
        tblDocument.reloadData()
        tblHeightConstraint.constant = CGFloat(43 * grData.event_documents!.count)
        }
    }
}

extension DetailEventContentTVCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrEventDocument.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDocument.dequeueReusableCell(withIdentifier: "DocumentContentCell", for: indexPath) as! DocumentContentCell
        cell.txtPresentation.isUserInteractionEnabled = false
        cell.txtPresentation.text = arrEventDocument[indexPath.row].name
        cell.btnDownloadOutlet.tag = indexPath.row
        cell.btnDownloadOutlet.addTarget(self, action: #selector(self.DownloadDocument), for: .touchUpInside)

        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objUrl = arrEventDocument[indexPath.row].file
        
        let vc = FlowController().instantiateViewController(identifier: "PDFReaderVC", storyBoard: "Category") as! PDFReaderVC
        vc.isFromDetailPage = true
        if objUrl != ""{
            vc.detailPageurl = BaseURL + objUrl!
        }
        detailVC.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    
    @objc func DownloadDocument(sender: UIButton){
        GlobalObj.displayLoader(true, show: true)
        let objUrl = arrEventDocument[sender.tag].file
      
        if let url = URL(string: BaseURL + objUrl!){
            GlobalObj.run(after: 2) {
                
                FileDownloader.loadFileAsync(url: url) { (path, error) in
                    print("PDF File downloaded to : \(path!)")
                    OperationQueue.main.addOperation {

                    GlobalObj.displayLoader(true, show: false)
                    self.detailVC.showToast(message: "PDF File downloaded")
                    }

                }
            }
        }
    }
}

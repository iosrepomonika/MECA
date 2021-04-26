//
//  DetailEventContentTVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 20/04/21.
//

import UIKit

class DetailEventContentTVCell: UITableViewCell {

    @IBOutlet weak var tblDocument: UITableView!
    @IBOutlet weak var Titledocument: UILabel!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    var arrEventDocument = [Event_documents]()
    
    var detailVC : NewDetailVC!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
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
        tblDocument.register(DocumentContentCell.nib(), forCellReuseIdentifier: "DocumentContentCell")
        tblDocument.delegate = self
        tblDocument.dataSource = self
        tblDocument.reloadData()
        tblHeightConstraint.constant = CGFloat(43 * dataEvent.event_documents!.count)
        }
    }
    func setKaizenData(dataKaizen:KaizenInfoDataModel) {
        if dataKaizen.kaizen_documents?.count == 0{
            tblHeightConstraint.constant = 0

        }else{
            print("dataKaizen.kaizen_documents?.count\(dataKaizen.kaizen_documents?.count)")
            if dataKaizen.kaizen_documents!.count > 0 {
               arrEventDocument.removeAll()
            }
            print(dataKaizen.kaizen_documents?.count)
            arrEventDocument = dataKaizen.kaizen_documents!
        tblDocument.register(DocumentContentCell.nib(), forCellReuseIdentifier: "DocumentContentCell")
        tblDocument.delegate = self
        tblDocument.dataSource = self
        tblDocument.reloadData()
        tblHeightConstraint.constant = CGFloat(43 * dataKaizen.kaizen_documents!.count)
        }
    }
}

extension DetailEventContentTVCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrEventDocument.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDocument.dequeueReusableCell(withIdentifier: "DocumentContentCell", for: indexPath) as! DocumentContentCell
        if detailVC.isEvent{
            
        }else{
            cell.txtPresentation.layer.borderWidth = 1
            cell.txtPresentation.layer.borderColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
            cell.txtPresentation.layer.cornerRadius = 4
            cell.txtPresentation.textColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
            cell.btnDownloadOutlet.setImage(UIImage(named: "download BlueDocuments"), for: UIControl.State.normal)
                
        }
        cell.txtPresentation.isUserInteractionEnabled = false
        cell.txtPresentation.text = arrEventDocument[indexPath.row].name
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
    
    
}

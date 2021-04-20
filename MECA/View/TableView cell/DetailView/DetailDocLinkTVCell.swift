//
//  DetailDocLinkTVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 20/04/21.
//

import UIKit

class DetailDocLinkTVCell: UITableViewCell {
    @IBOutlet weak var tblDocument: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    var arrDocumentLink = [Document_links]()
    
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
        tblHeightConstraint.constant = 0

    }
    
    func setKaizenData(dataKaizen:KaizenInfoDataModel) {
        if dataKaizen.document_links!.count > 0 {
//            arrDocumentLink.count > 0; do {
               self.arrDocumentLink.removeAll()
//            }
            arrDocumentLink = dataKaizen.document_links!
            tblDocument.register(DetailDocumentLinkTVCell.nib(), forCellReuseIdentifier: "DetailDocumentLinkTVCell")
            tblDocument.delegate = self
            tblDocument.dataSource = self
            tblHeightConstraint.constant = CGFloat(40*arrDocumentLink.count)
            tblDocument.reloadData()
        }
    
    }
}
extension DetailDocLinkTVCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDocumentLink.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDocument.dequeueReusableCell(withIdentifier: "DetailDocumentLinkTVCell", for: indexPath) as! DetailDocumentLinkTVCell
        cell.lblDocumentLink.text = arrDocumentLink[indexPath.row].link
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objLink = arrDocumentLink[indexPath.row].link ?? ""

        guard let url = URL(string: objLink) else { return }
        UIApplication.shared.open(url)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}

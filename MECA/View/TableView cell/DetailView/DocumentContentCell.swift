//
//  DocumentContentCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 20/04/21.
//

import UIKit

class DocumentContentCell: UITableViewCell {

    @IBOutlet weak var btnDownloadOutlet: UIButton!
    @IBOutlet weak var txtPresentation: UITextField!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if GlobalValue.tabCategory == "GR"{
            txtPresentation.layer.borderWidth = 1
            txtPresentation.layer.borderColor = #colorLiteral(red: 1, green: 0.1473276019, blue: 0, alpha: 1)
            txtPresentation.layer.cornerRadius = 4
            txtPresentation.textColor = #colorLiteral(red: 1, green: 0.1473276019, blue: 0, alpha: 1)
            btnDownloadOutlet.setImage(#imageLiteral(resourceName: "download_document_Red"), for: .normal)
        }else if GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            txtPresentation.layer.borderWidth = 1
            txtPresentation.layer.borderColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
            txtPresentation.layer.cornerRadius = 4
            btnDownloadOutlet.setImage(#imageLiteral(resourceName: "download Documents_Blue"), for: .normal)
            txtPresentation.textColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)

        }else{
            txtPresentation.layer.borderWidth = 1
            txtPresentation.layer.borderColor = #colorLiteral(red: 0.9803921569, green: 0.6235294118, blue: 0.2039215686, alpha: 1)
            txtPresentation.layer.cornerRadius = 4
            btnDownloadOutlet.setImage(#imageLiteral(resourceName: "download document"), for: .normal)
            txtPresentation.textColor = #colorLiteral(red: 0.9803921569, green: 0.6235294118, blue: 0.2039215686, alpha: 1)

        }
    }
    static func nib() -> UINib {
        return UINib(nibName: "DocumentContentCell", bundle: nil)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

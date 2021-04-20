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
        txtPresentation.layer.borderWidth = 1
        txtPresentation.layer.borderColor = #colorLiteral(red: 0.9803921569, green: 0.6235294118, blue: 0.2039215686, alpha: 1)
        txtPresentation.layer.cornerRadius = 4

    }
    static func nib() -> UINib {
        return UINib(nibName: "DocumentContentCell", bundle: nil)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

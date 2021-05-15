

import UIKit

class DocumentContentCell: UITableViewCell {

    @IBOutlet weak var btnDownloadOutlet: UIButton!
    @IBOutlet weak var txtPresentation: UITextField!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if GlobalValue.tabCategory == "GR"{
            txtPresentation.layer.borderWidth = 1
            txtPresentation.layer.borderColor = UIColor.getCustomRedColor().cgColor
            txtPresentation.layer.cornerRadius = 4
            txtPresentation.textColor = UIColor.getCustomRedColor()
            btnDownloadOutlet.setImage(#imageLiteral(resourceName: "download_document_Red"), for: .normal)
        }else if GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            txtPresentation.layer.borderWidth = 1
            txtPresentation.layer.borderColor = UIColor.getCustomBlueColor().cgColor
            txtPresentation.layer.cornerRadius = 4
            btnDownloadOutlet.setImage(#imageLiteral(resourceName: "download Documents_Blue"), for: .normal)
            txtPresentation.textColor = UIColor.getCustomBlueColor()

        }else{
            txtPresentation.layer.borderWidth = 1
            txtPresentation.layer.borderColor = UIColor.getCustomOrangeColor().cgColor
            txtPresentation.layer.cornerRadius = 4
            btnDownloadOutlet.setImage(#imageLiteral(resourceName: "download document"), for: .normal)
            txtPresentation.textColor = UIColor.getCustomOrangeColor()

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

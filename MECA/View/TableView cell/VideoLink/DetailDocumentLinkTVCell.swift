

import UIKit

class DetailDocumentLinkTVCell: UITableViewCell {

    @IBOutlet weak var lblDocumentLink: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if GlobalValue.tabCategory == "GR"{
            lblDocumentLink.textColor = #colorLiteral(red: 0.9882352941, green: 0, blue: 0, alpha: 1)
        }else{
            lblDocumentLink.textColor = #colorLiteral(red: 0.2972462177, green: 0.5657805204, blue: 0.8644942045, alpha: 1)
        }
    }
    static func nib() -> UINib {
        return UINib(nibName: "DetailDocumentLinkTVCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

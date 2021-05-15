

import UIKit
import SDWebImage
class GRLinksTVCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnOpenLinkOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "GRLinksTVCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(listObj:Link_Data) {
       lblTitle.text = listObj.title
        let imgurl = listObj.icon ?? ""
        let url = BaseURL + imgurl
       imgIcon.sd_imageIndicator = SDWebImageActivityIndicator.gray
      imgIcon.sd_setImage(with: URL(string: url), completed: nil)
    }
    
}

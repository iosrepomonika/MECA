

import UIKit
import SDWebImage
class DistributorListTVCell: UITableViewCell {
 
    @IBOutlet weak var imgFeed: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAdmin: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgFeed.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgFeed.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellNewCar(feed:DataKaizen) {
        print(feed)
        lblTitle.text = feed.title!
        lblDate.text = feed.start_date
        if let ownerprofile = feed.ownerprofile {
            lblAdmin.text = ownerprofile.username
        }
        
        if feed.cover_image != "" {
            let imgUrl = BaseURL + feed.cover_image!
            imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgFeed.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
        
    }
}

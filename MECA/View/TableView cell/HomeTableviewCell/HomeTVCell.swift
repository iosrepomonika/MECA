

import UIKit
import SDWebImage
class HomeTVCell: UITableViewCell {
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var viewIMG: UIView!
    
    @IBOutlet weak var imgFeed: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblWritternBy: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgFeed.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgFeed.layer.cornerRadius = 16
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "HomeTVCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCell(feed:Data_Home) {
        print("feed\(feed)")
        lblTitle.text = feed.title
        lblEventName.text = feed.whatsnew_type_lable
        let convertedFormat =  GlobalObj.convertToString(dateString: feed.created_at!)
        lblDate.text = convertedFormat
        let writerName = feed.writer_name!
        lblWritternBy.text = "Written by: \(writerName)"
        if feed.cover_image != "" {
            let imgUrl = BaseURL + feed.cover_image!
            imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgFeed.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
    }
    
    
    func setCellSdgs(feed:DataMaas) {
        print(feed)
        lblTitle.text = feed.title!
        let convertedFormat = GlobalObj.convertToString(dateString: feed.created_at!)
       
        
        lblDate.text = convertedFormat
        print("\(String(describing: feed.writername))")
        lblWritternBy.text = feed.writername
        if let ownerprofile = feed.ownerprofile {
           // lblAdmin.text = ownerprofile.username
        }
        
        if feed.cover_image != "" {
            let imgUrl = BaseURL + feed.cover_image!
            imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgFeed.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
        
    }

    
    func setCell2(feed:MEBITDataModel) {
        lblTitle.text = feed.title
        lblEventName.text = feed.whatsnew_type_lable
        let writerName = feed.writer_name!
        let convertedFormat = GlobalObj.convertToString(dateString: feed.created_at!)
     
        lblDate.text = convertedFormat
        lblWritternBy.text = "Written by: \(writerName)"
        if feed.cover_image != "" {
            let imgUrl = BaseURL + feed.cover_image!
            imgFeed.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgFeed.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }
    }
}



import UIKit

class DetailCommentLikeTVCell: UITableViewCell {

    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var imgLikes: UIImageView!
    @IBOutlet weak var imgComment: UIImageView!
    @IBOutlet weak var btnOutletLike: RCustomButton!
    @IBOutlet weak var btnOutletComment: RCustomButton!
    @IBOutlet weak var btnLikeCountOutlet: UIButton!
    @IBOutlet weak var btnCommentCountOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if GlobalValue.tabCategory == "GR" {
            imgLikes.image = #imageLiteral(resourceName: "likes_black")
            lblLike.textColor = .black
            imgComment.image = #imageLiteral(resourceName: "Comments_red")
            lblComment.textColor = UIColor.getCustomBlueColor()
        }else if  GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            imgLikes.image = #imageLiteral(resourceName: "likes_Blue")
            lblLike.textColor = UIColor.getCustomBlueColor()
            imgComment.image = #imageLiteral(resourceName: "comments_Blue")
            lblComment.textColor = UIColor.getCustomLightBlueColor()
        }else{
            imgLikes.image = #imageLiteral(resourceName: "Likes")
            lblLike.textColor = UIColor.getCustomDarkOrangeColor()
            imgComment.image = #imageLiteral(resourceName: "Comments")
            lblComment.textColor = UIColor.getCustomOrangeColor()
        }
        // Initialization code
    }

    static func nib() -> UINib {
        return UINib(nibName: "DetailCommentLikeTVCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setEventData(dataEvent:Data_Event) {
        let likes = String(dataEvent.likes ?? 0) + " Likes"
        let comments = String(dataEvent.comments_count ?? 0) + " Comments"

        lblLike.text = likes
        lblComment.text = comments
        
        
    }
    
    func setKaizenData(dataKaizen:KaizenInfoDataModel) {
        
        let likes = String(dataKaizen.likes ?? 0) + " Likes"
        let comments = String(dataKaizen.comments_count ?? 0) + " Comments"
        lblLike.text = likes
        lblComment.text = comments
        
    }
    func setGRData(grData:GRDetail_Data){
        let likes = String(grData.likes ?? 0) + " Likes"
        let comments = String(grData.comments_count ?? 0) + " Comments"
        lblLike.text = likes
        lblComment.text = comments    }
}

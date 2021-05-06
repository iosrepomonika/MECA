//
//  DetailCommentLikeTVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 20/04/21.
//

import UIKit

class DetailCommentLikeTVCell: UITableViewCell {

    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var imgLikes: UIImageView!
    @IBOutlet weak var imgComment: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        if GlobalValue.tabCategory == "GR" {
            imgLikes.image = #imageLiteral(resourceName: "likes_black")
            lblLike.textColor = .black
            imgComment.image = #imageLiteral(resourceName: "Comments_red")
            lblComment.textColor = #colorLiteral(red: 0.9882352941, green: 0, blue: 0, alpha: 1)
        }else if  GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            imgLikes.image = #imageLiteral(resourceName: "likes_Blue")
            lblLike.textColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
            imgComment.image = #imageLiteral(resourceName: "comments_Blue")
            lblComment.textColor = #colorLiteral(red: 0.2392156863, green: 0.4823529412, blue: 0.831372549, alpha: 1)
        }else{
            imgLikes.image = #imageLiteral(resourceName: "Likes")
            lblLike.textColor = #colorLiteral(red: 0.9650015235, green: 0.4383477867, blue: 0.2127818763, alpha: 1)
            imgComment.image = #imageLiteral(resourceName: "Comments")
            lblComment.textColor = #colorLiteral(red: 0.9803921569, green: 0.6235294118, blue: 0.2039215686, alpha: 1)
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

        lblLike.text = likes
        
        
    }
    
    func setKaizenData(dataKaizen:KaizenInfoDataModel) {
        
        let likes = String(dataKaizen.likes ?? 0) + " Likes"

        lblLike.text = likes
        
        
    }
}

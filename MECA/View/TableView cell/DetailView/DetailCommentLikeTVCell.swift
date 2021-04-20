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
    override func awakeFromNib() {
        super.awakeFromNib()
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

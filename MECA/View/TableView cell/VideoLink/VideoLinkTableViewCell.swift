//
//  VideoLinkTableViewCell.swift
//  MECA
//
//  Created by Mohammed Sulaiman on 16/04/21.
//

import UIKit

class VideoLinkTableViewCell: UITableViewCell {

    @IBOutlet weak var externalView: RCustomView!
    @IBOutlet weak var externalTitleLbl: UILabel!
    @IBOutlet weak var externalLinkLbl: UILabel!
    @IBOutlet weak var externalInfoLbl: UILabel!
    @IBOutlet weak var videoView: RCustomView!
    @IBOutlet weak var videoTitleLbl: UILabel!
    @IBOutlet weak var videoLinkLbl: UILabel!
    @IBOutlet weak var videoInfoLbl: UILabel!
    @IBOutlet weak var videoImg: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if GlobalValue.tabCategory == "GR"{
            videoLinkLbl.textColor = #colorLiteral(red: 1, green: 0.1473276019, blue: 0, alpha: 1)
        }else{
            videoLinkLbl.textColor = #colorLiteral(red: 0.2972462177, green: 0.5657805204, blue: 0.8644942045, alpha: 1)
        }
    }
    static func nib() -> UINib {
        return UINib(nibName: "VideoLinkTableViewCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  CommentReplyTVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 20/05/21.
//

import UIKit

class CommentReplyTVCell: UITableViewCell {
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var imgProfile: RCustomImageView!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var btnReplyOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(commentData : Subcomments) {
        print(commentData)
        lblComment.text = commentData.comment
        lblUserName.text = commentData.writer_name
        lbDay.text = commentData.created_at
    }
}

//
//  CommentDetailTVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 16/05/21.
//

import UIKit
import SDWebImage
class CommentDetailTVCell: UITableViewCell {
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfile: RCustomImageView!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var btnReplyOutlet: UIButton!
    @IBOutlet weak var tblSublist: UITableView!
    @IBOutlet weak var tblSubListHeughtConstriaint: NSLayoutConstraint!
    @IBOutlet weak var viewSendComment: UIView!
    @IBOutlet weak var viewSendCommentBoxHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgComment: UIImageView!
    @IBOutlet weak var imgCommentHeightConstraint: NSLayoutConstraint!
    
    var arrSubComment = [Subcomments]()
    var tableViewHeight: CGFloat = 0
    var tblComment = UITableView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //
        //viewSendCommentBoxHeightConstraint.constant = 0
        
        self.tblSublist.estimatedRowHeight = 100.0
        self.tblSublist.rowHeight = UITableView.automaticDimension
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib {
        return UINib(nibName: "CommentDetailTVCell", bundle: nil)
    }
    
    func setCell(commentData : CommentListData) {
        print(commentData)
        if commentData.subcomments!.count>0{
            if arrSubComment.count>0{
                arrSubComment.removeAll()
            }
            arrSubComment = commentData.subcomments!
            tblSublist.register(UINib.init(nibName: "CommentReplyTVCell", bundle: nil), forCellReuseIdentifier: "CommentReplyTVCell")
            tblSublist.dataSource = self
            tblSublist.delegate = self
            viewSendComment.isHidden = true
            viewSendCommentBoxHeightConstraint.constant = 0
            tblSublist.isHidden = false
            tblSublist.reloadData()
            tblSubListHeughtConstriaint.constant = tblSublist.contentSize.height
            tblSublist.layoutIfNeeded()
            self.updateConstraints()
            tblComment.reloadData()
            
        }else{
            viewSendComment.isHidden = true
            tblSublist.isHidden = true
            tblSubListHeughtConstriaint.constant = 0
            viewSendCommentBoxHeightConstraint.constant = 0
        }
        if commentData.isfile == 1{
            if let urlstr = commentData.comment {
                let url = BaseURL + urlstr
                imgComment.contentMode = .scaleToFill
                imgCommentHeightConstraint.constant = 150
                lblDescription.isHidden = true
                imgComment.sd_setImage(with: URL.init(string: url), completed: nil)
      
            }
        }else{
            lblDescription.text = commentData.comment
            imgCommentHeightConstraint.constant = 0
            lblDescription.isHidden = false
            imgComment.isHidden = true
        }
        
        lblUserName.text = commentData.writer_name
        lblUserName.font = UIFont.init(name: "SF-Pro-Display-Bold", size: 13)
        lblDay.text =  commentData.created_at
        
    }
}

extension CommentDetailTVCell : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSubComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tblSublist.dequeueReusableCell(withIdentifier: "CommentReplyTVCell", for: indexPath) as! CommentReplyTVCell
        
        cell.setCell(commentData: arrSubComment[indexPath.row])
        cell.btnReplyOutlet.addTarget(self, action: #selector(btnReplyViewOpenAtion), for: .touchUpInside)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   
 
    
    @objc func btnReplyViewOpenAtion(sender : UIButton){
        if sender.isSelected {
            sender.isSelected = false
            viewSendCommentBoxHeightConstraint.constant = 0
            sender.setTitle("Reply", for: .normal)
            viewSendComment.isHidden = true

           tblComment.beginUpdates()
            tblComment.endUpdates()
        }else{
            sender.isSelected = true
            viewSendCommentBoxHeightConstraint.constant = 40
            viewSendComment.isHidden = false
            sender.setTitle("Cancel", for: .normal)
            tblComment.beginUpdates()
             tblComment.endUpdates()
        }
    }
    
}

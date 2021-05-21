//
//  LikeOrCommentVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 12/05/21.
//

import UIKit

class LikeOrCommentVC: UIViewController {
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var viewSendComment: UIView!
    @IBOutlet weak var txtViewSendComment: UITextView!
   
    @IBOutlet weak var btnOutletSendComment: UIButton!
    
    @IBOutlet weak var viewSendCommentHeightConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var lblHeader: UILabel!
    
    var viewModel : LikeOrCommentVM!
    var isFromLike = ""
    var imgDoc = NSData()
    var module = 0
    var item = 0
    var detailVC = NewDetailVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LikeOrCommentVM.init(controller: self)

        if isFromLike == "Like"{
            viewSendCommentHeightConstraint.constant = 0
            tblList.register(LikeDetailTVCell.nib(), forCellReuseIdentifier: "LikeDetailTVCell")
            lblHeader.text = "Like"
        }else{
            lblHeader.text = "Comments"
            tblList.register(CommentDetailTVCell.nib(), forCellReuseIdentifier: "CommentDetailTVCell")
            viewSendCommentHeightConstraint.constant = 80
            txtViewSendComment.layer.cornerRadius = 20
            txtViewSendComment.layer.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
            txtViewSendComment.layer.masksToBounds = true
            viewModel.callWebserviceForCommentList(module: String(module), item: String(item))
        }
     
        if GlobalValue.tabCategory == "GR" {
            btnOutletSendComment.setImage(#imageLiteral(resourceName: "RED_comment"), for: .normal)
        }else if  GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            btnOutletSendComment.setImage(#imageLiteral(resourceName: "Blue_comment"), for: .normal)
        }else{
            btnOutletSendComment.setImage(#imageLiteral(resourceName: "orange_comment"), for: .normal)
        }
    }
    @IBAction func btnCrossAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.detailVC.viewDidLoad()
        }
    }
    @IBAction func btnSendCommentAction(_ sender: UIButton) {
        if txtViewSendComment.text == ""{
            self.showToast(message: "Please Enter Your Comment")
        }else{
            viewModel.callWebserviceForAddComment(module: String(module), item: String(item), parent: "0", isfile: "0", is_reply: "0", comment: txtViewSendComment.text!, imgData: imgDoc)

        }
    }
}

extension LikeOrCommentVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblList)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblList)
    }
}

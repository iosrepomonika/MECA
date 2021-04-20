//
//  NewDetailVC.swift
//  MECA
//
//  Created by Apoorva Gangrade on 20/04/21.
//

import UIKit

class NewDetailVC: UIViewController {

    @IBOutlet weak var tblDetailView: UITableView!
    var viewModel : NewDetailVM!
    var isEvent = false
    var eventID = ""
    @IBOutlet weak var viewImgPreview: UIView!
    @IBOutlet weak var imgPreview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewModel = NewDetailVM.init(controller: self)
        
        tblDetailView.register(DetailCoverImageTVCell.nib(), forCellReuseIdentifier: viewModel.identifierCoverImgCell)
        tblDetailView.register(DetailAboutEventTVCell.nib(), forCellReuseIdentifier: viewModel.identifierAboutCell)
        tblDetailView.register(DetailLocationTVCell.nib(), forCellReuseIdentifier: viewModel.identifierLocationCell)
        tblDetailView.register(DetailImagesAndVideosCell.nib(), forCellReuseIdentifier: viewModel.identifierImgesCell)
        tblDetailView.register(DetailEventContentTVCell.nib(), forCellReuseIdentifier: viewModel.identifierEventContentCell)
        tblDetailView.register(DetailVideoLinkTVCell.nib(), forCellReuseIdentifier: viewModel.identifierVideoLinkCell)
        tblDetailView.register(DetailDocLinkTVCell.nib(), forCellReuseIdentifier: viewModel.identifierDocumentLinkCell)
        tblDetailView.register(DetailCommentLikeTVCell.nib(), forCellReuseIdentifier: viewModel.identifierCommentLikeCell)

        viewImgPreview.isHidden = true
        
        if isEvent{
            viewModel.callEventInfoWebservice()
        }else{
            viewModel.callKaizenInfoWebservice { (result) in
                if result{
                    //self.tblDetailView.reloadData()
                }
            }
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.imgPreview
            {
                self.viewImgPreview.isHidden = true
            }
        }
}

extension NewDetailVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblDetailView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblDetailView)
    }
    
}

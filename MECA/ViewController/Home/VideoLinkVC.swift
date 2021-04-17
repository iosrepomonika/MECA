//
//  VideoLinkVC.swift
//  MECA


import UIKit

class VideoLinkVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: RCustomView!
    @IBOutlet weak var tblView: UITableView!
    var videoLinkValue = ""
    var videoLinkArr1 = [[String:Any]]()
    var docLinkArr1 = [[String:Any]]()
    var viewModel: VideoLinkVM!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = VideoLinkVM.init(controller: self)
    
        tblView.register(VideoLinkTableViewCell.nib(), forCellReuseIdentifier: "VideoLinkTableViewCell")
        tblView.delegate = self
        tblView.dataSource = self
     
        if videoLinkValue == "0" {
            //external link
            
        }
        else {
            //VideoLink
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func DismissBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if videoLinkValue == "0" {
            return docLinkArr1.count
        }
        else {
            return videoLinkArr1.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblView)
    }

}

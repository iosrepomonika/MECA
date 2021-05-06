//
//  GRActivityReportVC.swift
//  MECA
//


import UIKit

class GRActivityReportVC: UIViewController {

    @IBOutlet weak var tblActivity: UITableView!
   
    @IBOutlet weak var footerView: OrangeFooterView!
    var viewModel : GRActivityReportVM!
    var currentPage : Int = 1
    var checkPagination = ""
    
    private var pullControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tblActivity.refreshControl = pullControl
        } else {
            tblActivity.addSubview(pullControl)
        }
        // Do any additional setup after loading the view.
    }
    @objc private func refreshListData(_ sender: Any) {
        self.pullControl.endRefreshing()
        currentPage = 1
        self.checkPagination = "get"
        viewModel.callWebserviceForGRActivityVM()
    }
    func setupUI() {
        tblActivity.register(HomeTVCell.nib(), forCellReuseIdentifier: "HomeTVCell")
        tblActivity.delegate = self
        tblActivity.dataSource = self
        viewModel = GRActivityReportVM.init(controller: self)
        
        
        
        footerView.orangeFooterViewDelegate = self
        footerView.imgWhatsnew.image = UIImage.init(named: "Whats New")
        footerView.imgFromDistributor.image = UIImage.init(named: "Activity_Report_Active")
        footerView.imgFromTMC.image = UIImage.init(named: "Linkes")
        footerView.lblWhatsNew.text = "What's New"
        footerView.lblDistributor.text = "Activity Report"
        footerView.lblTMC.text = "Links"
        footerView.bgView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0, blue: 0, alpha: 1)
    }
  
    @IBAction func btnCrossAction(_ sender: UIButton) {
        let mainVC = FlowController().instantiateViewController(identifier: "NavCategory", storyBoard: "Category")
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = mainVC
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3

        UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
        { completed in
            // maybe do something on completion here
        })
        appDel.window?.makeKeyAndVisible()
    }
}
//MARK:- Footerview Delegate
extension GRActivityReportVC : OrangeFooterViewDelegate{
    
    
    func footerBarAction1(strType: String){
   
        if strType == "WhatsNew"{
            print("Type1")
            
            let vc = FlowController().instantiateViewController(identifier: "MEBITViewController", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else if strType == "FromDistributor"{
            print("Type2")
           
        }else if strType == "FromTMC"{
            print("Type3")
                let vc = FlowController().instantiateViewController(identifier: "GRLinksVC", storyBoard: "GR")
                self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}

//MARK:- UITableview Delegate DataSourcew
extension GRActivityReportVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblActivity)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblActivity)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, tableView: tblActivity)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                if indexPath.row == viewModel.arrGRList.count-1{
                    self.checkPagination = "pagination"
                    currentPage += 1
                    GlobalObj.run(after: 2) {
                        GlobalObj.displayLoader(true, show: true)
                        self.viewModel.callWebserviceForGRActivityVM()
                    }
                }
            }
        }
    }
}

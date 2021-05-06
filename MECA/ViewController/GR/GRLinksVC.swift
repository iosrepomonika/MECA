//
//  GRLinksVC.swift
//  MECA


import UIKit

class GRLinksVC: UIViewController {

    
    @IBOutlet weak var tblLinks: UITableView!
    @IBOutlet weak var footerView: OrangeFooterView!
    private var pullControl = UIRefreshControl()
    var viewModel : GRLinksVM!
    var currentPage : Int = 1
    var checkPagination = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tblLinks.refreshControl = pullControl
        } else {
            tblLinks.addSubview(pullControl)
        }
        setupUI()
        checkPagination = "get"
        viewModel.CallLinkListWebservice()
    }
    @objc private func refreshListData(_ sender: Any) {
        self.pullControl.endRefreshing()
        checkPagination = "get"
        currentPage = 1
        viewModel.CallLinkListWebservice()

    }
    func setupUI() {
        tblLinks.register(GRLinksTVCell.nib(), forCellReuseIdentifier: "GRLinksTVCell")
        tblLinks.delegate = self
        tblLinks.dataSource = self
        viewModel = GRLinksVM.init(controller: self)
        
        footerView.orangeFooterViewDelegate = self
        footerView.imgWhatsnew.image = UIImage.init(named: "Whats New")
        footerView.imgFromDistributor.image = UIImage.init(named: "Activity_Report")
        footerView.imgFromTMC.image = UIImage.init(named: "Linkes_Active")
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
extension GRLinksVC : OrangeFooterViewDelegate{
    
    
    func footerBarAction1(strType: String){
   
        if strType == "WhatsNew"{
            print("Type1")
            
            let vc = FlowController().instantiateViewController(identifier: "MEBITViewController", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else if strType == "FromDistributor"{
            print("Type2")
            let vc = FlowController().instantiateViewController(identifier: "GRActivityReportVC", storyBoard: "GR")
            self.navigationController?.pushViewController(vc, animated: false)

           
        }else if strType == "FromTMC"{
            print("Type3")

        }
    }
}
//MARK:- UITableview Delegate DataSourcew
extension GRLinksVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblLinks)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblLinks)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, tableView: tblLinks)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                if indexPath.row == viewModel.arrLinkList.count-1{
                    self.checkPagination = "pagination"
                    currentPage += 1
                    GlobalObj.run(after: 2) {
                        
                        self.viewModel.CallLinkListWebservice()
                    }
                }
            }
        }
    }

}
    

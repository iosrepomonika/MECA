

import UIKit

class MEBITViewController: UIViewController {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: RCustomView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var dismissRefBtn: UIButton!
    @IBOutlet weak var MEBITTableView: UITableView!
    @IBOutlet weak var footerView: OrangeFooterView!
    var headerImageValue = ""
    var currentPage : Int = 1
    var checkPagination = ""
    
    var viewModel : MEBITHomeVM!
    private var pullControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MEBITHomeVM.init(controller: self)
        MEBITTableView.register(HomeTVCell.nib(), forCellReuseIdentifier: "HomeTVCell")
        MEBITTableView.delegate = self
        MEBITTableView.dataSource = self
        footerView.orangeFooterViewDelegate = self
        setupUI()
        if GlobalValue.tabCategory == "MEBIT"{
            viewModel.callMEBITFeedWebservice()
        }else if GlobalValue.tabCategory == "GR"{
            currentPage = 1
            self.checkPagination = "get"
            viewModel.callWebserviceForGRHome()
        }
        // Do any additional setup after loading the view.
        pullControl.tintColor = UIColor.gray
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            MEBITTableView.refreshControl = pullControl
        } else {
            MEBITTableView.addSubview(pullControl)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()

    }
    
    @objc private func refreshListData(_ sender: Any) {
        if GlobalValue.tabCategory == "MEBIT"{
      
            viewModel.callMEBITFeedWebservice()
      
        }else if GlobalValue.tabCategory == "GR"{
            currentPage = 1
            self.checkPagination = "get"
            viewModel.callWebserviceForGRHome()
        }
        self.pullControl.endRefreshing()

     
        }
    func setupUI() {
        if headerImageValue == "0" {
            headerImage.image = UIImage(named: "MEBIT1")
            
        }
        else if headerImageValue == "1" {
            
        }
        else if headerImageValue == "2" {
            
        }
        else if headerImageValue == "3" {
            
        }
        else if headerImageValue == "4" {
            //SDGS
            headerImage.image = UIImage(named: "SDGS")
        }
        else if headerImageValue == "5" {
            headerImage.image = UIImage(named: "GR_Cat")
        }
        
        if GlobalValue.tabCategory == "MEBIT"{
        footerView.imgWhatsnew.image = UIImage.init(named: "Whats New active")
        footerView.imgFromDistributor.image = UIImage.init(named: "From Distributor")
        footerView.imgFromTMC.image = UIImage.init(named: "From TMC")
        footerView.lblWhatsNew.text = "What's New"
        footerView.lblDistributor.text = "From Distributor"
        footerView.lblTMC.text = "From TMC"
        footerView.bgView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.3529411765, blue: 0.1568627451, alpha: 1)
       
        }else if GlobalValue.tabCategory == "GR"{
       
        footerView.imgWhatsnew.image = UIImage.init(named: "Whats New active")
        footerView.imgFromDistributor.image = UIImage.init(named: "Activity_Report")
        footerView.imgFromTMC.image = UIImage.init(named: "Linkes")
        footerView.lblWhatsNew.text = "What's New"
        footerView.lblDistributor.text = "Activity Report"
        footerView.lblTMC.text = "Links"
        footerView.bgView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0, blue: 0, alpha: 1)
            
        }
    }
}
//MARK:- UIButton Action
extension  MEBITViewController{
    @IBAction func onClickDismiss(_ sender: UIButton) {
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
//MARK:- Footer view
extension  MEBITViewController : OrangeFooterViewDelegate{
   

    func footerBarAction1(strType: String){
   
        if strType == "WhatsNew"{
            print("Type1")
            

            
        }else if strType == "FromDistributor"{
            print("Type2")
            if GlobalValue.tabCategory == "MEBIT"{
                let vc = FlowController().instantiateViewController(identifier: "CategoryDistributorVC", storyBoard: "Category")
                self.navigationController?.pushViewController(vc, animated: false)
                
            }else if GlobalValue.tabCategory == "GR"{
                
                let vc = FlowController().instantiateViewController(identifier: "GRActivityReportVC", storyBoard: "GR")
                self.navigationController?.pushViewController(vc, animated: false)
            }
            
        }else if strType == "FromTMC"{
            print("Type3")
            if GlobalValue.tabCategory == "MEBIT"{
                let vc = FlowController().instantiateViewController(identifier: "TMCViewController", storyBoard: "Category")
                self.navigationController?.pushViewController(vc, animated: false)

            }else if GlobalValue.tabCategory == "GR"{
                let vc = FlowController().instantiateViewController(identifier: "GRLinksVC", storyBoard: "GR")
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
   
    }
}

//MARK:- UITableview Delegate Datasource
extension MEBITViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: MEBITTableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 292
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel.getHeightForHeaderAt(section, tableView: MEBITTableView)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        viewModel.getBaseTableHeaderViewFor(section, tableView: MEBITTableView)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if GlobalValue.tabCategory == "MEBIT"{
        let story = UIStoryboard(name: "Category", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
        let obj = viewModel.arrMEBITFeed[indexPath.row]
        vc.eventID = String(obj.id ?? 0)
        vc.isEvent =  obj.whatsnew_type == "event" ? true : false
        self.navigationController?.pushViewController(vc, animated: true)
        }else if GlobalValue.tabCategory == "GR"{
            let story = UIStoryboard(name: "Category", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
            let obj = viewModel.arrGRList[indexPath.row]
            vc.eventID = String(obj.id ?? 0)
            vc.isFromGR = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if GlobalValue.tabCategory == "GR"{
           if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
               if indexPath == lastVisibleIndexPath {
                   if indexPath.row == viewModel.arrGRList.count-1{
                       self.checkPagination = "pagination"
                       currentPage += 1
                       GlobalObj.run(after: 2) {
                        self.viewModel.callWebserviceForGRHome()
                       }
                   }
               }
           }
       }
    }
}




import UIKit

class MEBITViewController: UIViewController {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: RCustomView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var dismissRefBtn: UIButton!
    @IBOutlet weak var MEBITTableView: UITableView!
    @IBOutlet weak var footerView: OrangeFooterView!
    var headerImageValue = ""
    var viewModel : MEBITHomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MEBITHomeVM.init(controller: self)
        MEBITTableView.register(HomeTVCell.nib(), forCellReuseIdentifier: "HomeTVCell")
        MEBITTableView.delegate = self
        MEBITTableView.dataSource = self
        footerView.orangeFooterViewDelegate = self
        setupUI()
        viewModel.callMEBITFeedWebservice()
        // Do any additional setup after loading the view.
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
            
        }
        
        footerView.imgWhatsnew.image = UIImage.init(named: "Whats New active")
        footerView.imgFromDistributor.image = UIImage.init(named: "From Distributor")
        footerView.imgFromTMC.image = UIImage.init(named: "From TMC")
        
    }
    
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
extension  MEBITViewController : OrangeFooterViewDelegate{
   

    func footerBarAction1(strType: String){
   
        if strType == "WhatsNew"{
            print("Type1")
            

            
        }else if strType == "FromDistributor"{
            print("Type2")
            
            let vc = FlowController().instantiateViewController(identifier: "CategoryDistributorVC", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)
        }else if strType == "FromTMC"{
            print("Type3")
            
            let vc = FlowController().instantiateViewController(identifier: "TMCViewController", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)

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
        
        let story = UIStoryboard(name: "Category", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        // vc.modalPresentationStyle = .fullScree
        let obj = viewModel.arrMEBITFeed[indexPath.row]
        vc.eventID = String(obj.id ?? 0)
        vc.isEvent =  obj.whatsnew_type == "event" ? true : false
        vc.navValue = "1"
        // self.present(vc, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
}


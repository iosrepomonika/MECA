

import UIKit

class CategoryDistributorVC: UIViewController {
 
    @IBOutlet weak var footerView: OrangeFooterView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        footerView.orangeFooterViewDelegate = self
        // Do any additional setup after loading the view.
        setValue()
    }
    
    func setValue()  {
        
        footerView.imgWhatsnew.image = UIImage.init(named: "Whats New")
        footerView.imgFromDistributor.image = UIImage.init(named: "From Distributor active")
        footerView.imgFromTMC.image = UIImage.init(named: "From TMC")
    }
    
    @IBAction func btnCrossAction(_ sender: Any) {
        
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
    
    @IBAction func btnSelectAction(_ sender: UIButton) {
        if sender.tag == 10{
            //new car sale
            let vc = FlowController().instantiateViewController(identifier: "NewCarSalesViewController", storyBoard: "Category") as! NewCarSalesViewController
            vc.strComeFrom = "Distributor"
            vc.type = 1
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if  sender.tag == 20 {
            //Tranding
            let vc = FlowController().instantiateViewController(identifier: "NewCarSalesViewController", storyBoard: "Category") as! NewCarSalesViewController
            vc.strComeFrom = "Distributor"
            vc.type = 2

            self.navigationController?.pushViewController(vc, animated: true)

        }else if sender.tag == 30 {
            //After sale
            let vc = FlowController().instantiateViewController(identifier: "NewCarSalesViewController", storyBoard: "Category") as! NewCarSalesViewController
            
            vc.strComeFrom = "Distributor"
            vc.type = 3
            self.navigationController?.pushViewController(vc, animated: true)

        }else if sender.tag == 40 {
            let vc = FlowController().instantiateViewController(identifier: "NewCarSalesViewController", storyBoard: "Category") as! NewCarSalesViewController
            
            vc.strComeFrom = "Distributor"
            vc.type = 4
            self.navigationController?.pushViewController(vc, animated: true)
            //BitFoundation
        }else if sender.tag == 50 {
            //Orginasation
        }
             
    }
    

}

extension CategoryDistributorVC : OrangeFooterViewDelegate{
    func footerBarAction1(strType: String) {
        if strType == "WhatsNew"{
            print("Type1")
            let vc = FlowController().instantiateViewController(identifier: "MEBITViewController", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)

            
        }else if strType == "FromDistributor"{
            print("Type2")
            
            
        }else if strType == "FromTMC"{
            print("Type3")
            
            let vc = FlowController().instantiateViewController(identifier: "TMCViewController", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)

        }
        
        
    }
    
    
}

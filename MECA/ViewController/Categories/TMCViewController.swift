

import UIKit

class TMCViewController: UIViewController {

    @IBOutlet weak var newCarSalesView: RCustomView!
    
    @IBOutlet weak var tradeInView: RCustomView!
    
    @IBOutlet weak var afterSalesView: RCustomView!
  
    @IBOutlet weak var viewFooter: OrangeFooterView!
    
    @IBAction func btnSelectAction(_ sender: UIButton) {
        if sender.tag == 10{
            let story = UIStoryboard(name: "Category", bundle:nil)
                        let vc = story.instantiateViewController(withIdentifier: "PDFReaderVC") as! PDFReaderVC
            vc.isFromTab = "what_is_mebit"
                    self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 20 {
            let story = UIStoryboard(name: "Category", bundle:nil)
                        let vc = story.instantiateViewController(withIdentifier: "PDFReaderVC") as! PDFReaderVC
            vc.isFromTab = "Overall"
                    self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 30 {
            let story = UIStoryboard(name: "Category", bundle:nil)
                        let vc = story.instantiateViewController(withIdentifier: "MEBITEventVC") as! MEBITEventVC
                    self.navigationController?.pushViewController(vc, animated: true)

        }else if sender.tag == 40 {
            let story = UIStoryboard(name: "Category", bundle:nil)
                        let vc = story.instantiateViewController(withIdentifier: "NewCarSalesViewController") as! NewCarSalesViewController
                    vc.strComeFrom = "TMC"
                    vc.type = 4
                    self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 50 {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView1))
        newCarSalesView.isUserInteractionEnabled = true
        newCarSalesView.addGestureRecognizer(gestureRecognizer)
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(didTapView2))
        afterSalesView.isUserInteractionEnabled = true
        afterSalesView.addGestureRecognizer(gestureRecognizer1)
        
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(didTapView3))
        tradeInView.isUserInteractionEnabled = true
        tradeInView.addGestureRecognizer(gestureRecognizer2)

        
        viewFooter.orangeFooterViewDelegate = self
        viewFooter.imgWhatsnew.image = UIImage.init(named: "Whats New")
        viewFooter.imgFromDistributor.image = UIImage.init(named: "From Distributor")
        viewFooter.imgFromTMC.image = UIImage.init(named: "From TMC active")
        
        // Do any additional setup after loading the view.
    }
    @objc func didTapView1() {
        
            let story = UIStoryboard(name: "Category", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "NewCarSalesViewController") as! NewCarSalesViewController
        vc.strComeFrom = "TMC"
        vc.type = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapView2() {
        
            let story = UIStoryboard(name: "Category", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "NewCarSalesViewController") as! NewCarSalesViewController
        vc.strComeFrom = "TMC"
        vc.type = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapView3() {
        
            let story = UIStoryboard(name: "Category", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "NewCarSalesViewController") as! NewCarSalesViewController
        vc.strComeFrom = "TMC"
        vc.type = 3
        self.navigationController?.pushViewController(vc, animated: true)
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
}

extension TMCViewController : OrangeFooterViewDelegate{
    func footerBarAction1(strType: String) {
        if strType == "WhatsNew"{
            print("Type1")
            let vc = FlowController().instantiateViewController(identifier: "MEBITViewController", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)

            
        }else if strType == "FromDistributor"{
            print("Type2")
            let vc = FlowController().instantiateViewController(identifier: "CategoryDistributorVC", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else if strType == "FromTMC"{
            print("Type3")
            
            

        }
        
        
    }
    
    
}

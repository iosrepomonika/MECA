

import UIKit

class MoreVC: UIViewController {
    @IBOutlet weak var viewFooter: FooterTabView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewFooter.footerTabViewDelegate = self
        setview()
    }
    
    func setview()  {
        viewFooter.footerTabViewDelegate = self
        viewFooter.imgMore.image = UIImage.init(named: "More_Active")
        viewFooter.imgHome.image = UIImage.init(named: "Home_Inactive")
    }
    @IBAction func btnprofileAction(_ sender: UIButton) {
        let story = UIStoryboard(name: "More", bundle:nil)
      //  let obj = arrList[indexPath.row]
        let vc = story.instantiateViewController(withIdentifier: "Editprofilevc") as! EditprofileVC
        
        
      
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    @IBAction func btnChatAction(_ sender: UIButton) {
    }
    @IBAction func btnreminderAction(_ sender: UIButton) {
        let story = UIStoryboard(name: "More", bundle:nil)
     
        let vc = story.instantiateViewController(withIdentifier: "Remindervc") as! ReminderVC
        
        
      
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnchangepasswordAction(_ sender: UIButton) {
        let story = UIStoryboard(name: "More", bundle:nil)
      
        let vc = story.instantiateViewController(withIdentifier: "Changepasswordvc") as! ChangepasswordVC
        
        
      
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnsupportAction(_ sender: UIButton) {
        let story = UIStoryboard(name: "More", bundle:nil)
      //  let obj = arrList[indexPath.row]
        let vc = story.instantiateViewController(withIdentifier: "Supportvc") as! SupportVC
        
        
      
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btntermsAction(_ sender: UIButton) {
    }
    @IBAction func btnprivacyAction(_ sender: UIButton) {
    }
    @IBAction func btnSignOutAction(_ sender: UIButton) {
        let mainVC = FlowController().instantiateViewController(identifier: "NavMain", storyBoard: "Main")
        userDef.removeObject(forKey: UserDefaultKey.token)
        userDef.synchronize()
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
extension MoreVC : FooterTabViewDelegate{
    func footerBarAction(strType: String) {
        if strType == "Home"{
            let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.window?.rootViewController = mainVC
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3

            UIView.transition(with: appDel.window!, duration: duration, options: options, animations: {}, completion:
            { completed in
                // maybe do something on completion here
            })
            appDel.window?.makeKeyAndVisible()

        }else if strType == "Calendar"{
            
            
            
        }else if strType == "Categories"{

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

       
        }else if strType == "Notification"{
            
        }else{
            
        }
    }
    
    
}

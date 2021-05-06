

import UIKit

class MoreVC: UIViewController {
    @IBOutlet weak var viewFooter: FooterTabView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewFooter.footerTabViewDelegate = self
        
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

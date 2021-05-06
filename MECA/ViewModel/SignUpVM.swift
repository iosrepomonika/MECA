

import UIKit

class SignUpVM: NSObject {
    var actualController:UIViewController?
    
    init(controller:UIViewController?) {
        self.actualController = controller
    }
}

extension SignUpVM{
    func callSignUpWebservice(param:[String:Any]) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webServiceForSignUp(params: param) { (response) in
            GlobalObj.displayLoader(true, show: false)
            if let resDict = response as? NSDictionary {
                
                        if let res = resDict["resp_code"] as? Int{
                            if res == 401 {
                                if let resError = resDict["errors"] as? NSDictionary{
                                    if let error = resError["error"] as? String{
                                        
                                        if error == "Your account has been created we will review and let you know soon"{
                                            GlobalObj.displayAlertWithHandler(with: "", message: error, buttons: ["OK"], viewobj: (self.actualController as! SignUpVC).self, buttonStyles: [.default]) { (buttonTab) in
                                                (self.actualController as! SignUpVC).navigationController?.popViewController(animated: true)
                                            }
                                        }else{
                                            GlobalObj.displayLoader(true, show: false)

                                        }
                                        }
                                    }else{
                                        GlobalObj.displayLoader(true, show: false)

                                    }
            
                                }
                            }
                        }
            }
   
        }
}

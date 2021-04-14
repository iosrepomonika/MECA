

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

            (self.actualController as!
                SignUpVC).navigationController?.popViewController(animated: true)
//            if let status = response["authstatus"] as? Int {
//                if status == 1{
//
//                }
//            }
            
        }
    }
}

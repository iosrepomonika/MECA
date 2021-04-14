

import Foundation
import UIKit

import Foundation
import UIKit

class CreateKaizenVM: NSObject {
    var actualController:UIViewController?
    
    init(controller:UIViewController?) {
        self.actualController = controller
    }
}

extension CreateKaizenVM{
//    func webServiceForCreateKaizen(param:[String:Any]) {
//        GlobalObj.displayLoader(true, show: true)
//        APIClient.webServiceForCreateKaizen(params: param) { (response) in
//            GlobalObj.displayLoader(true, show: false)
//
//            (self.actualController as!
//                CategoryCommonViewController).navigationController?.popViewController(animated: true)
////            if let status = response["authstatus"] as? Int {
////                if status == 1{
////
////                }
////            }
//            
//        }
//    }
}

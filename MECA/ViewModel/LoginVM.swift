
import UIKit

class LoginVM: NSObject {
  
    var actualController:UIViewController?
    
    init(controller:UIViewController?) {
        self.actualController = controller
    }
}

//MARK:- Call Webserviece an all methords
extension LoginVM{
   
    
    func callLoginWebservice(email:String,password:String) {
        GlobalObj.displayLoader(true, show: true)
        let param = ["email":email,
                     "password":password]
        APIClient.webServicesToSignIn(params: param) { (response) in
            print("login response\(response)")
            if response.status == 1{
                GlobalObj.displayLoader(true, show: false)
                print("login fn\(response.first_name)")
                print("login ln\(response.last_name)")
                print("login phone\(response.phone)")
                print("login email\(response.email)")
                print("login avatar\(response.avatar)")
                userDef.set(response.first_name, forKey: UserDefaultKey.fname)
                userDef.set(response.last_name, forKey: UserDefaultKey.lname)
                userDef.set(response.avatar, forKey: UserDefaultKey.profileimg)
                userDef.set(response.phone, forKey: UserDefaultKey.phone)
                userDef.set(response.email, forKey: UserDefaultKey.email)
                
                userDef.set(response.token, forKey: UserDefaultKey.token)
                userDef.synchronize()
                UserDefaults.standard.set(true, forKey: "ISLOGGEDIN")
                let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
                UIApplication.shared.windows.first?.rootViewController = mainVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            
            }else{
              
                    UserDefaults.standard.set(false, forKey: "ISLOGGEDIN")
                GlobalObj.displayLoader(true, show: false)
                GlobalObj.showAlertVC(title: "Alert", message: "Invalid email or password", controller: (self.actualController as! LoginVC).self)
            }
        }
    }
}

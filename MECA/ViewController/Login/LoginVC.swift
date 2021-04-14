
import UIKit
import KRProgressHUD

class LoginVC: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
   
    var viewmodel : LoginVM!
    var iconClick = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel = LoginVM.init(controller: self)

//        if UserDefaults.standard.bool(forKey: "ISLOGGEDIN") == true {
//            let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
//            UIApplication.shared.windows.first?.rootViewController = mainVC
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
//
//        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickShowPassword(_ sender: UIButton) {
        if(iconClick == true) {
                   txtPassword.isSecureTextEntry = false
                } else {
                    txtPassword.isSecureTextEntry = true
                }

                iconClick = !iconClick
    }
    
}

//MARK:- Custom Methord
extension LoginVC{
    func validation(){
//        
//        if GlobalObj.isValidEmail(testStr: txtEmail.text!){
//            print("Validate EmailID")
//      
//        }else{
//            KRProgressHUD.dismiss()
//            print("invalid EmailID")
//            GlobalObj.showAlert(title: "Invalid Data", message: "Please Enter Valid EmailID", controller: self)
//        }
        if txtEmail.text == "" && txtPassword.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Email Id and Password", controller: self)
            
        }else if txtEmail.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Email Id", controller: self)

        }else if txtPassword.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Password", controller: self)

        }else if !(GlobalObj.isValidEmail(testStr: txtEmail.text!)){
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Valid EmailID", controller: self)

        }else{
            viewmodel.callLoginWebservice(email: txtEmail.text!, password: txtPassword.text!)
        }
    }
}
//MARK:- UIButton Action
extension LoginVC{
    @IBAction func btnSignUPAction(_ sender: UIButton) {
        let vc = FlowController().instantiateViewController(identifier: "SignUpVC", storyBoard: "Main")

        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func btnLogin(_ sender: UIButton) {
        validation()

    }
    
}

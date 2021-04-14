

import UIKit
import KRProgressHUD

class SignUpVC: UIViewController, SignUpListViewDelgate {
   


    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
   
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNum: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    var iconClick = true
    
   
   
    @IBOutlet weak var lblSelectDistributor: UILabel!
  
    @IBOutlet weak var lblSelectDivision: UILabel!
    
    var viewModel : SignUpVM!
    var disctributorID = 0
    var divisionID = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignUpVM.init(controller: self)
        
        
    }

func distributorListData(distributor: String, distributorId: Int) {
    if distributor != ""{
        lblSelectDistributor.text = distributor
        
        let id = distributorId
        self.disctributorID = id
    }
    }
    
    func divisionListData(division: String, disionId: Int) {

        if division != "" {
            lblSelectDivision.text = division
            let id = disionId
            self.divisionID = id
        }
    }
}

//MARK:- Custom Methord
extension SignUpVC{
    func validation(){
        
//        if GlobalObj.isValidatePhoneNumber(value: txtPhoneNum.text!) {
//            print("Valid Phone Number")
//        }
//        else {
//            KRProgressHUD.dismiss()
//        }
       
        if txtFirstname.text == "" && txtLastname.text == "" && txtEmail.text == "" && txtPhoneNum.text == "" && txtPassword.text == "" && lblSelectDistributor.text == "Select Distributor" && lblSelectDivision.text == "Select Division" && txtConfirmPassword.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter All Feilds", controller: self)
            
        }else if txtFirstname.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter First Name", controller: self)
            
        }else if txtLastname.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Last Name", controller: self)

        }else if txtPhoneNum.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Email Id", controller: self)
            
        }else if txtEmail.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Email Id", controller: self)
            
        }else if txtPassword.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Password", controller: self)
            
        }else if txtConfirmPassword.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Confrim Password", controller: self)

        }else if txtConfirmPassword.text != txtPassword.text{
            GlobalObj.showAlertVC(title: "Oops", message: "Password and Confirm password is not match", controller: self)
            
        }else if lblSelectDistributor.text == "Select Distributor"{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Password", controller: self)

        }else if lblSelectDivision.text == "Select Division"{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Password", controller: self)
       
        }else if !(txtPhoneNum.text!.isPhoneNumber){
//        if !(GlobalObj.isValidatePhoneNumber(value: txtPhoneNum.text!)) {
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Valid Phone Number", controller: self)


        }else {
            let param : [String:Any] = ["email":txtEmail.text!,
                                        "password":txtPassword.text!,
                                        "first_name":txtFirstname.text!,
                                        "last_name":txtLastname.text!,
                                        "distributor":disctributorID,
                                        "division":divisionID,
                                        "confirm_password":txtConfirmPassword.text!,
                                        "phone":txtPhoneNum.text!]
            print(param)
            viewModel.callSignUpWebservice(param: param)
        }
    }
}

//MARK :- UIButton Action
extension SignUpVC{
    
    @IBAction func btnDivisionAction(_ sender: UIButton) {
        if lblSelectDistributor.text == "Select Distributor"{
            GlobalObj.showAlertVC(title: "Oops", message: "Please First Select Distributor", controller: self)
        }else{
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "SignUpListViewVC") as! SignUpListViewVC
        vc.modalPresentationStyle = .fullScreen
            BoolValue.isFromDistributor = false
            vc.signUpListViewDelgate = self
            let DistributorId:String = String(disctributorID)
            vc.Distributor_Id = DistributorId

        self.present(vc, animated: true, completion: nil)
        }
    }
  
    @IBAction func btnSelectDistributorAction(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "SignUpListViewVC") as! SignUpListViewVC
        vc.modalPresentationStyle = .fullScreen
        vc.signUpListViewDelgate = self
        BoolValue.isFromDistributor = true
        self.present(vc, animated: true, completion: nil)
    }
   
    @IBAction func btnLoginAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnSignUpAction(_ sender: UIButton) {
       validation()
    }
  
    @IBAction func btnEyeAction(_ sender: UIButton) {
        if sender.tag == 10{
            if(iconClick == true) {
                       txtPassword.isSecureTextEntry = false
                    } else {
                        txtPassword.isSecureTextEntry = true
                    }

                    iconClick = !iconClick
        }else{
            if(iconClick == true) {
                       txtConfirmPassword.isSecureTextEntry = false
                    } else {
                        txtConfirmPassword.isSecureTextEntry = true
                    }

                    iconClick = !iconClick
        }
       
    }
}

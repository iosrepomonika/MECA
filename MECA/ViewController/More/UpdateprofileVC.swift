//
//  UpdateprofileVC.swift
//  MECA
//
//  Created by Macbook  on 11/05/21.
//

import UIKit
import SDWebImage
class UpdateprofileVC: UIViewController {
    @IBOutlet weak var fnametxt:UITextField!
    @IBOutlet weak var lnametxt:UITextField!
    @IBOutlet weak var emailtxt:UITextField!
    @IBOutlet weak var phonetxt:UITextField!
    @IBOutlet weak var editimg:UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userfname = userDef.string(forKey: "fname")!
        let userlname =  userDef.string(forKey: "lname")!
        fnametxt.text = userfname
        lnametxt.text = userlname
        let useremail = userDef.string(forKey: "email")
        emailtxt.text = useremail
        let userphonenumber = userDef.string(forKey: "phone")
        phonetxt.text = userphonenumber
        let userprofile = userDef.string(forKey: "profileimg")
        if userprofile == "" {
      
        }else{
            let url = BaseURL + userprofile!
            editimg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            editimg.sd_setImage(with: URL.init(string: url), completed: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



import UIKit

class AboutDetailVC: UIViewController {

   
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    var strdescrtiption = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblText.text = strdescrtiption
    }
    @IBAction func btnCrossAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

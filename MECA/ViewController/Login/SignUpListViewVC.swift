

import UIKit
protocol SignUpListViewDelgate {
    func distributorListData(distributor: String,distributorId:Int)
    func divisionListData(division: String,disionId:Int)  //data: string is an example parameter
}

class SignUpListViewVC: UIViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblList: UITableView!
    var viewModel : SignUpListViewVM!
    
    var Distributor_Id = ""

    var signUpListViewDelgate : SignUpListViewDelgate!
    var tableFilterDistributorData:[DistributorModel] = []
    var tableFilterDivisionData:[DivisionModel] = []

    var searching:Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignUpListViewVM.init(controller: self)
        tblList.register(SignUpListTVCell.nib(), forCellReuseIdentifier: viewModel.identifierItemCell)
        txtSearch.delegate = self
        if BoolValue.isFromDistributor{
            viewModel.callWebserviceForDistributor()
        }else{
            viewModel.callWebserviceForDivision()
        }
      
    }

    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}

extension SignUpListViewVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: tblList)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getHeightForRowAt(indexPath, tableView: tblList)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, tableView: tblList)
    }
}

extension SignUpListViewVC : UITextFieldDelegate{
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{

        if BoolValue.isFromDistributor{
            let searchText  = textField.text! + string
          //add matching text to arrya
            tableFilterDistributorData = viewModel.arrDistribute.filter({(($0.name)!.localizedCaseInsensitiveContains(searchText))})

        if searchText.count == 1{
            searching = false
          }else{
            searching = true
            print(tableFilterDistributorData.count)
         }
        }else{
            let searchText  = textField.text! + string
          //add matching text to arrya
            tableFilterDivisionData = viewModel.arrDivision.filter({(($0.division_name)!.localizedCaseInsensitiveContains(searchText))})

            if searchText.count == 1{
            searching = false
          }else{
            searching = true
         }
        }
        
      self.tblList.reloadData()

      return true
    }
}

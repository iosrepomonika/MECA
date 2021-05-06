//
//  SDGSCategoryVC.swift
//  MECA
//
//  Created by Macbook  on 15/04/21.
//

import UIKit

class SDGSVC: UIViewController  {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: RCustomView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var dismissRefBtn: UIButton!
    @IBOutlet weak var SDGSTableView: UITableView!
    @IBOutlet weak var footerView: BlueFooterview!
    var viewModel : SDGSHomeVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SDGSHomeVM.init(controller: self)
        SDGSTableView.register(HomeTVCell.nib(), forCellReuseIdentifier: "HomeTVCell")
        SDGSTableView.delegate = self
        SDGSTableView.dataSource = self
        footerView.blueFooterViewDelegate = self
        footerView.imgWhatsnew.image = #imageLiteral(resourceName: "Whats New active")
        footerView.imgFromDCategory.image = #imageLiteral(resourceName: "Categories_inActive")
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated )
        viewModel.newsdgsHomeApicall()

    }
    @IBAction func onClickDismiss(_ sender: UIButton) {
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
extension  SDGSVC : BlueFooterViewDelegate{
   

    func footerBarAction1(strType: String){
   print("strType\(strType)")
        if strType == "WhatsNew"{
            print("Type1")
            
            
            
        }else if strType == "Categories"{
            print("Type2")
            
            let vc = FlowController().instantiateViewController(identifier: "SDGSCategoryVC", storyBoard: "Category")
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
        
    }
    

}
//MARK:- UITableview Delegate Datasource
extension SDGSVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForRowAt(indexPath, tableView: SDGSTableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 292
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel.getHeightForHeaderAt(section, tableView: SDGSTableView)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        viewModel.getBaseTableHeaderViewFor(section, tableView: SDGSTableView)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, tableView: SDGSTableView)
        
        
        
        
    }
}

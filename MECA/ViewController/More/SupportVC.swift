//
//  SupportVC.swift
//  MECA
//
//  Created by Macbook  on 10/05/21.
//

import UIKit

class SupportVC: UIViewController {
    
   
    
    @IBOutlet weak var headerView: RCustomView!
    @IBOutlet weak var supporttblview:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        supporttblview.estimatedRowHeight = 125
        self.supporttblview.rowHeight = UITableView.automaticDimension
        supporttblview?.register(Supporttblcell.nib, forCellReuseIdentifier: Supporttblcell.identifier)
        supporttblview?.dataSource = self
        supporttblview?.delegate = self
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
//Mark: - Tableview Datasource Methods
extension SupportVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Supporttblcell.identifier, for: indexPath) as? Supporttblcell
        
         return cell!
    }
}
//MARK: - TableView Delegate Methods
extension SupportVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: SDGSListTableCell.identifier, for: indexPath) as? SDGSListTableCell
//        cell!.backgroundColor = UIColor.white
//
//        let obj = arrList[indexPath.row]
//
//
//        let story = UIStoryboard(name: "Category", bundle:nil)
//      //  let obj = arrList[indexPath.row]
//        let vc = story.instantiateViewController(withIdentifier: "SDGSListVC") as! SDGSListvc
//        vc.idvalue = String(obj.id ?? "0")
//        vc.headerImageValue = String(obj.lable ?? "0")
//
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.SDGSCategoryTableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

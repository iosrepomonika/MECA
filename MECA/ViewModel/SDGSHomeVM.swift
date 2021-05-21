//
//  SDGSHomeVM.swift
//  MECA
//
//  Created by Macbook  on 20/04/21.
//

import UIKit
import Foundation

class SDGSHomeVM: BaseTableViewVM {

    let identifierItemCell = "HomeTVCell"
    var arrMEBITFeed:[MEBITDataModel] = []
    var arrList : [DataMaas] = []
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        baseHeaderTableViewHeight = 70
    }

    override func getNumbersOfRows(in section: Int) -> Int {
        return arrList.count
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierItemCell, for: indexPath) as! HomeTVCell
        let objFeed = arrList[indexPath.row]
        cell.lblEventName.isHidden = true
        cell.setCellSdgs(feed: objFeed)
        return cell

    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        print("select tableview cell ")
        let story = UIStoryboard(name: "Category", bundle:nil)
        let obj = arrList[indexPath.row]
        let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
        print("String(obj.id ?? 0) sdgs \(String(obj.id ?? 0))")
        vc.eventID = String(obj.id ?? 0)
        vc.isEvent = false
        vc.module = "SDGs"
        vc.ComingfromVC = "Sdgs"
        vc.Maasview = true
        (actualController as! SDGSVC).navigationController?.pushViewController(vc, animated: true)
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        return 50
    }
    override func getHeightForHeaderAt(_ section: Int, tableView: UITableView) -> CGFloat {
    return 50
    }
    override func getBaseTableHeaderViewFor(_ section: Int, tableView: UITableView) -> UIView? {

        let headerView:UIView =  UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        let label = UILabel(frame: CGRect(x: 16, y: 15, width: 200, height: 20))
        label.text = "What's new"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        headerView.addSubview(label)

        
            return headerView

}
    
    
    
    func newsdgsHomeApicall()  {
       
        let param : [String:Any] = [
                                    "type" : 0]//"keyword" : "test"
        print(param)
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForSDGSlistapi(limit: "10",page: "1",params: param) { (result) in
            print("whats new api response \(result)")
            if let repo = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
               
                if repo == 200 {
                    
                    if let arrList = result.data{
                        print(arrList)
                        if arrList.count > 0  {
                            self.arrList.removeAll()
                        }
                        for obj in arrList {
                            self.arrList.append(obj)
                        }
                        
                    }
                    (self.actualController as! SDGSVC).SDGSTableView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }else{
                
                
                GlobalObj.displayLoader(true, show: false)
            }
        }
        
    }
    
    
    


}

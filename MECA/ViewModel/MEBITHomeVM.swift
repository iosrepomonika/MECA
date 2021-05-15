

import Foundation

import UIKit

class MEBITHomeVM: BaseTableViewVM {
   
    let identifierItemCell = "HomeTVCell"
    var arrMEBITFeed:[MEBITDataModel] = []
    var arrGRList = [GRHomeLis_Data]()
    
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        baseHeaderTableViewHeight = 70
    }
    override func getNumbersOfRows(in section: Int) -> Int {
        if GlobalValue.tabCategory == "MEBIT"{
            return arrMEBITFeed.count
        }else if GlobalValue.tabCategory == "GR"{
            return arrGRList.count
        }
        return 2
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierItemCell, for: indexPath) as! HomeTVCell
        if GlobalValue.tabCategory == "MEBIT"{
            let objFeed = arrMEBITFeed[indexPath.row]
            cell.setCell2(feed: objFeed)
        
        }else if GlobalValue.tabCategory == "GR"{
            let objFeed = arrGRList[indexPath.row]
            cell.setCellGR(feed: objFeed)
        }
        
        
        return cell

    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        if GlobalValue.tabCategory == "MEBIT"{
        let story = UIStoryboard(name: "Category", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
        let obj = arrMEBITFeed[indexPath.row]
        vc.eventID = String(obj.id ?? 0)
        vc.isEvent =  obj.whatsnew_type == "event" ? true : false
            (self.actualController as! MEBITViewController).navigationController?.pushViewController(vc, animated: true)
        }else if GlobalValue.tabCategory == "GR"{
            let story = UIStoryboard(name: "Category", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
            let obj = arrGRList[indexPath.row]
            vc.eventID = String(obj.id ?? 0)
            vc.isFromGR = true
            (self.actualController as! MEBITViewController).navigationController?.pushViewController(vc, animated: true)
        }
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
    
    func callMEBITFeedWebservice() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForMEBITFeed { (result) in
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)

                if respCode == 200{
                    if let arrDate = result.data{
                        for objData in arrDate {
                            self.arrMEBITFeed.append(objData)
                        }
                    }
                    if self.arrMEBITFeed.count>0{
                        (self.actualController as! MEBITViewController).MEBITTableView.isHidden = false
                    }else{
                        (self.actualController as! MEBITViewController).MEBITTableView.isHidden = true
                    }
                    (self.actualController as! MEBITViewController).MEBITTableView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
    }
    
    func callWebserviceForGRHome(){
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForGRHomeList(limit: "10", page: String((self.actualController as! MEBITViewController).currentPage), Type: "", params: [:], isFromGRHome: true) { (result) in
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    if let arrDate = result.data{
                        if (self.actualController as! MEBITViewController).checkPagination == "get"{
                            self.arrGRList.removeAll()
                        }
                        for objData in arrDate {
                            self.arrGRList.append(objData)
                        }
                        if self.arrGRList.count > 0{
                            (self.actualController as! MEBITViewController).MEBITTableView.isHidden = false
                        }else{
                            (self.actualController as! MEBITViewController).MEBITTableView.isHidden = true

                        }
                    }
                    (self.actualController as! MEBITViewController).MEBITTableView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
    }
}

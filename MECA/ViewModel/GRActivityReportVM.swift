//
//  GRActivityReportVM.swift
//  MECA
//


import UIKit

class GRActivityReportVM: BaseTableViewVM {
    var arrGRList = [GRHomeLis_Data]()

    override init(controller: UIViewController?) {
        super.init(controller: controller)
    (self.actualController as! GRActivityReportVC).checkPagination = "get"
        GlobalObj.displayLoader(true, show: true)

        callWebserviceForGRActivityVM()
    }
    override func getNumbersOfRows(in section: Int) -> Int {
        return arrGRList.count
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVCell", for: indexPath) as! HomeTVCell
        cell.lblEventName.text = ""
        cell.newImage.isHidden = true
        let obj = arrGRList[indexPath.row]
        cell.setCellGR(feed: obj)
        return cell
    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        
        let story = UIStoryboard(name: "Category", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
        let obj = arrGRList[indexPath.row]
        vc.eventID = String(obj.id ?? 0)
        vc.isFromGR = true
        (self.actualController as! GRActivityReportVC).navigationController?.pushViewController(vc, animated: true)
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        return 292
    }
    
    func callWebserviceForGRActivityVM(){
        APIClient.webserviceForGRHomeList(limit: "10", page: String((self.actualController as! GRActivityReportVC).currentPage), Type: "0", params: [:], isFromGRHome: false) { (result) in
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    if let arrDate = result.data{
                        if (self.actualController as! GRActivityReportVC).checkPagination == "get"{
                            self.arrGRList.removeAll()
                        }
                        for objData in arrDate {
                            self.arrGRList.append(objData)
                        }
                    }
                    if self.arrGRList.count > 0 {
                        (self.actualController as! GRActivityReportVC).tblActivity.isHidden = false
                    }else{
                        (self.actualController as! GRActivityReportVC).tblActivity.isHidden = true
                    }
                    (self.actualController as! GRActivityReportVC).tblActivity.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
    }
}

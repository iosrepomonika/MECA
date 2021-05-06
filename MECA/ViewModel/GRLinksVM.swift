//
//  GRLinksVM.swift
//  MECA
//


import UIKit
import SDWebImage

class GRLinksVM:  BaseTableViewVM {
    var arrLinkList = [Link_Data]()
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        
    }
    override func getNumbersOfRows(in section: Int) -> Int {
        return arrLinkList.count
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GRLinksTVCell", for: indexPath) as! GRLinksTVCell
        let objList = arrLinkList[indexPath.row]
        cell.setCell(listObj: objList)
        cell.btnOpenLinkOutlet.tag = indexPath.row
        cell.btnOpenLinkOutlet.addTarget(self, action: #selector(didTapLinkButton), for: .touchUpInside)

        return cell
    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
//            let story = UIStoryboard(name: "Category", bundle:nil)
//            let vc = story.instantiateViewController(withIdentifier: "NewDetailVC") as! NewDetailVC
//            let obj = arrLinkList[indexPath.row]
//            vc.eventID = String(obj.id ?? 0)
//            vc.isFromGR = true
//            (self.actualController as! GRLinksVC).navigationController?.pushViewController(vc, animated: true)
       
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        return 292
    }
    @objc func didTapLinkButton(sender:UIButton) {
        let objLink = arrLinkList[sender.tag].href
        let vc = FlowController().instantiateViewController(identifier: "PDFReaderVC", storyBoard: "Category") as! PDFReaderVC
        vc.isFromDetailPage = true
        vc.detailPageurl = objLink ?? ""
        (self.actualController as! GRLinksVC).navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func CallLinkListWebservice() {
        GlobalObj.displayLoader(true, show: true)
        
        APIClient.webserviceForGRLinkList(limit: "10", page: String((self.actualController as! GRLinksVC).currentPage), params: [:]) { (result) in
            
            if let respCode = result.resp_code{
                GlobalObj.displayLoader(true, show: false)
                if respCode == 200{
                    if let arrDate = result.data{
                        if (self.actualController as! GRLinksVC).checkPagination == "get"{
                            
                            self.arrLinkList.removeAll()
                        }
                        if arrDate.count == 0 {
                            GlobalObj.displayLoader(true, show: false)
                            return
                        }
                        for objData in arrDate {
                            self.arrLinkList.append(objData)
                        }
                    }
                    (self.actualController as! GRLinksVC).tblLinks.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            GlobalObj.displayLoader(true, show: false)
            

        }
    }
}

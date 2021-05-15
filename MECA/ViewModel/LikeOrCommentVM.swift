//
//  LikeOrCommentVM.swift
//  MECA
//
//  Created by Apoorva Gangrade on 12/05/21.
//

import UIKit

class LikeOrCommentVM: BaseTableViewVM {
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        
    }
    override func getNumbersOfRows(in section: Int) -> Int {
        return 5
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GRLinksTVCell", for: indexPath) as! GRLinksTVCell
    
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
    
}

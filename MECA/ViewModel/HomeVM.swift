

import UIKit
import AVFoundation

class HomeVM: BaseTableViewVM {
   
    let identifierItemCell = "HomeTVCell"
    var arrHomeFeed:[Data_Home] = []

    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        baseHeaderTableViewHeight = 70
    }
    
    override func getNumbersOfRows(in section: Int) -> Int {
        return arrHomeFeed.count
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierItemCell, for: indexPath) as! HomeTVCell
        let objFeed = arrHomeFeed[indexPath.row]
        cell.setCell(feed: objFeed)
        return cell

    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {

        let story = UIStoryboard(name: "Category", bundle:nil)
        let obj = arrHomeFeed[indexPath.row]
        let vc = story.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.navValue = "0"
        vc.eventID = String(obj.id ?? 0)
		vc.isEvent =  obj.whatsnew_type == "event" ? true : false
        (actualController as! HomeVC).navigationController?.pushViewController(vc, animated: true)
        
       
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
    func callHomeFeedWebservice() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.wevserviceForHomeFeed { (result) in

            if let respCode = result.resp_code{
             
                if respCode == 200{
                    if let arrDate = result.data{
                        if self.arrHomeFeed.count>0{
                            self.arrHomeFeed.removeAll()
                        }
                        for objData in arrDate {
                            self.arrHomeFeed.append(objData)
                        }
                    }
                    (self.actualController as! HomeVC).tblView.reloadData()
                }else{
                    GlobalObj.displayLoader(true, show: false)

                }
            }
            
            GlobalObj.displayLoader(true, show: false)

        }
    }
}

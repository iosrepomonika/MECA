
import UIKit

class NewCarSalesVM: BaseTableViewVM {
    
    let identifierItemCell = "HomeTVCell"
    var arrMEBITFeed:[NewCarKaizenModel] = []

    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        baseHeaderTableViewHeight = 70
    }
    override func getNumbersOfRows(in section: Int) -> Int {
        return arrMEBITFeed.count
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierItemCell, for: indexPath) as! HomeTVCell
        let objFeed = arrMEBITFeed[indexPath.row]
      //  cell.setCell2(feed: objFeed)
        return cell

    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        
//        if indexPath.row == 0 {
//
//            let vc = FlowController().instantiateViewController(identifier: "DetailViewController", storyBoard: "Category")
//            vc.navigationController?.pushViewController(vc, animated: true)
//
//        }
//        else if indexPath.row == 1 {
//
//        }
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
    
//    func callMEBITFeedWebservice() {
//        GlobalObj.displayLoader(true, show: true)
//        APIClient.webserviceForMEBITFeed { (result) in
//            if let respCode = result.resp_code{
//
//                if respCode == 200{
//                    if let arrDate = result.data{
//                        for objData in arrDate {
//                            self.arrMEBITFeed.append(objData)
//                        }
//                    }
//                    (self.actualController as! MEBITViewController).MEBITTableView.reloadData()
//                }
//            }
//
//            GlobalObj.displayLoader(true, show: false)
//
//        }
//    }
}

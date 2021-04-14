

import UIKit

class SignUpListViewVM: BaseTableViewVM {
    
    let identifierItemCell = "SignUpListTVCell"
    var arrDistribute:[DistributorModel] = []
    var arrDivision:[DivisionModel] = []
    
    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
        baseHeaderTableViewHeight = 70
    }
   
    override func getNumbersOfRows(in section: Int) -> Int {
        if BoolValue.isFromDistributor{
            if (self.actualController as! SignUpListViewVC).searching{
                
                return (self.actualController as! SignUpListViewVC).tableFilterDistributorData.count
                
            }else{
                
                return arrDistribute.count
                
            }
        }else{
            if (self.actualController as! SignUpListViewVC).searching{
              
                return (self.actualController as! SignUpListViewVC).tableFilterDivisionData.count
            }else{
                
                return arrDivision.count
            }
        }
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if BoolValue.isFromDistributor{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpListTVCell", for: indexPath) as! SignUpListTVCell
            
            if (self.actualController as! SignUpListViewVC).searching{
                let listModel = (self.actualController as! SignUpListViewVC).tableFilterDistributorData[indexPath.row]
                cell.lblTitle.text = listModel.name
            }else{
                let ListModel = arrDistribute[indexPath.row]
                cell.lblTitle.text = ListModel.name
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpListTVCell", for: indexPath) as! SignUpListTVCell
            if (self.actualController as! SignUpListViewVC).searching{
                
                let listModel = (self.actualController as! SignUpListViewVC).tableFilterDivisionData[indexPath.row]
                cell.lblTitle.text = listModel.division_name
                
            }else{
                let ListModel = arrDivision[indexPath.row]
                cell.lblTitle.text = ListModel.division_name
            }
            return cell
        }
        

    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
        if BoolValue.isFromDistributor{
            if (self.actualController as! SignUpListViewVC).searching{
             
                let ListModel = (self.actualController as! SignUpListViewVC).tableFilterDistributorData[indexPath.row]
                (actualController as! SignUpListViewVC).signUpListViewDelgate.distributorListData(distributor: ListModel.name ?? "Select Distributor", distributorId: ListModel.id ?? 0)
                (actualController as! SignUpListViewVC).dismiss(animated: true, completion: nil)

            }else{
                let ListModel = arrDistribute[indexPath.row]
                (actualController as! SignUpListViewVC).signUpListViewDelgate.distributorListData(distributor: ListModel.name ?? "Select Distributor", distributorId: ListModel.id ?? 0)
                (actualController as! SignUpListViewVC).dismiss(animated: true, completion: nil)

            }
            
        }else{
         
            if (self.actualController as! SignUpListViewVC).searching{
                let ListModel = (self.actualController as! SignUpListViewVC).tableFilterDivisionData[indexPath.row]
                (actualController as! SignUpListViewVC).signUpListViewDelgate.divisionListData(division: ListModel.division_name ?? "Select Division", disionId: ListModel.id ?? 0)
                (actualController as! SignUpListViewVC).dismiss(animated: true, completion: nil)
            }else{
                let ListModel = arrDivision[indexPath.row]
                (actualController as! SignUpListViewVC).signUpListViewDelgate.divisionListData(division: ListModel.division_name ?? "Select Division", disionId: ListModel.id ?? 0)
                (actualController as! SignUpListViewVC).dismiss(animated: true, completion: nil)
            }
            
            

        }
        
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        return 50

    }

}

//MARK :- Webservice Call
extension SignUpListViewVM{
    func callWebserviceForDistributor(){
        GlobalObj.displayLoader(true, show: true)
        APIClient.webServicesForDistributorList(params: [:]) { (response) in
            print(response)
            
            let arrResponse = (response as! NSArray)
            self.parseListData(arrResponse)

            GlobalObj.displayLoader(true, show: false)
        }
    }
    func parseListData(_ arrResponse : NSArray){
        if arrDistribute.count>0{
            arrDistribute.removeAll()
        }
        
        for objLict in arrResponse {
            let obj = objLict as! NSDictionary
            let objDict = DistributorModel(dictionary: obj)!
            arrDistribute.append(objDict)

        }
        (actualController as! SignUpListViewVC).tblList.reloadData()
    }
    func callWebserviceForDivision(){
        GlobalObj.displayLoader(true, show: true)
        print((actualController as? SignUpListViewVC)!.Distributor_Id)
        let id = (actualController as! SignUpListViewVC).Distributor_Id
        APIClient.webServicesForDivisionList(Division_Id: id, params: [:]) { (response) in
            print(response)
            let arrResponse = (response as! NSArray)
            self.parseDivisionData(arrResponse)

            GlobalObj.displayLoader(true, show: false)
        }
    }
    func parseDivisionData(_ arrResponse : NSArray){
        if arrDivision.count>0{
            arrDivision.removeAll()
        }
        
        for objLict in arrResponse {
            let obj = objLict as! NSDictionary
            let objDict = DivisionModel(dictionary: obj)!
            arrDivision.append(objDict)

        }
        (actualController as! SignUpListViewVC).tblList.reloadData()
    }
}

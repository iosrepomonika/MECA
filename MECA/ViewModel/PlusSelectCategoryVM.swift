

import UIKit

class PlusSelectCategoryVM: BaseCollectionViewVM {
   
    var arrCat = ["News","MEBIT","MaaS","Hydrogen","SDGs","GR"]
    var arrcatImg = [UIImage.init(named: "News"),UIImage.init(named: "MEBIT"),UIImage.init(named: "MaaS"),UIImage.init(named: "Hydrogen"),UIImage.init(named: "SDGs"),UIImage.init(named: "GR")]
    var arrModule = [Modules]()

    override init(controller: UIViewController?) {
        
        super.init(controller: controller)
      actualController = controller
        nibItem = "InstagramImageCVCell"
        identifierItem = "InstagramImageCVCell"
        
        callWebserviceCategory()

    }
    
    override func getItemForRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "PlusSelectCategoryCVCell", for: indexPath) as! PlusSelectCategoryCVCell
        cell.imgCatIcon.image = arrcatImg[indexPath.row]
        cell.lblCatName.text = arrCat[indexPath.row]
        return cell
        
    }
    func didSelectRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) {
     
        if indexPath.row == 0 {
            let vc = FlowController().instantiateViewController(identifier: "AddNewsViewController", storyBoard: "Home")
            let objCat = arrCat[indexPath.row]
            for objModule in arrModule {
                if objCat == objModule.module {
                    print(objModule)
                }
            }
            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1{
            //CategoryCommonViewController
            let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
            
            vc.myTitle = "Add MEBIT Report"
            vc.module = 0
            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)

        }
        else if indexPath.row == 2{
            let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
            let objCat = arrCat[indexPath.row]
            for objModule in arrModule {
                if objCat.capitalized == objModule.module {
                    print(objModule)
                    vc.module = objModule.id ?? 0
                }
            }
            vc.myTitle = "Add New MaaS"

            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)

        }
        else if indexPath.row == 3{
            
            let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
            let objCat = arrCat[indexPath.row]
            for objModule in arrModule {
                if objCat == objModule.module {
                    print(objModule)
                    vc.module = objModule.id ?? 0
                }
            }
            vc.myTitle = "Add New Hydrogen"

            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)
       
        }
        else if indexPath.row == 4{
            let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
            let objCat = arrCat[indexPath.row]
            for objModule in arrModule {
                if objCat == objModule.module {
                    print(objModule)
                    vc.module = objModule.id ?? 0
                }
            }
            vc.myTitle = "Add New SDGs"

            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)
       
        }
        else if indexPath.row == 5{

            let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
            let objCat = arrCat[indexPath.row]
            for objModule in arrModule {
                if objCat == objModule.module {
                    print(objModule)
                    vc.module = objModule.id ?? 0
                }
            }
            vc.myTitle = "Add New GR"

            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    
    func getSizeForItem(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: collectionView.frame.size.width / 2, height: 145)
    }
    
        //Module
        func callWebserviceCategory() {
            APIClient.webserviceForCategoryList { (result) in
                
                if let respCode = result.resp_code{
                    
                    if respCode == 200{
                        // GlobalObj.displayLoader(true, show: false)
                        
                        if let arrDate = result.data{
                            if let arr = arrDate.modules{
                                self.arrModule = arr
                            }
                        }
                        
                    }else{
                        // GlobalObj.displayLoader(true, show: false)
                        
                    }
                }
                
                GlobalObj.displayLoader(true, show: false)
                
            }
            
        }
}

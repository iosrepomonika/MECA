

import UIKit

class PlusSelectCategoryVM: BaseCollectionViewVM {
   
    var arrCat = ["News","MEBIT","MaaS","Hydrogen","SDGs","GR"]
    var arrcatImg = [UIImage.init(named: "News"),UIImage.init(named: "MEBIT"),UIImage.init(named: "MaaS"),UIImage.init(named: "Hydrogen"),UIImage.init(named: "SDGs"),UIImage.init(named: "GR")]
    
    override init(controller: UIViewController?) {
        
        super.init(controller: controller)
      actualController = controller
        nibItem = "InstagramImageCVCell"
        identifierItem = "InstagramImageCVCell"

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
            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1{
            //CategoryCommonViewController
            let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
         
            vc.myTitle = "Add MEBIT Report"

            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)

        }
        else if indexPath.row == 2{
            let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
         
            vc.myTitle = "Add New MaaS"

            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)

        }
        else if indexPath.row == 3{
            
            let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
         
            vc.myTitle = "Add New Hydrogen"

            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)
       
        }
        else if indexPath.row == 4{
//            let story = UIStoryboard(name: "Home", bundle:nil)
//            let vc = story.instantiateViewController(withIdentifier: "CategoryCommonViewController") as! CategoryCommonViewController
//            vc.modalPresentationStyle = .fullScreen
//            vc.myTitle = "Add New SDGs"
//            self.present(vc, animated: true)
            let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
         
            vc.myTitle = "Add New SDGs"

            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)
       
        }
        else if indexPath.row == 5{
//            let story = UIStoryboard(name: "Home", bundle:nil)
//            let vc = story.instantiateViewController(withIdentifier: "CategoryCommonViewController") as! CategoryCommonViewController
//            vc.modalPresentationStyle = .fullScreen
//            vc.myTitle = "Add New GR"
//            self.present(vc, animated: true)
            let vc = FlowController().instantiateViewController(identifier: "CategoryCommonViewController", storyBoard: "Home") as! CategoryCommonViewController
         
            vc.myTitle = "Add New GR"

            (actualController as! PlusSelectCategoryVC).navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    
    func getSizeForItem(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: collectionView.frame.size.width / 2, height: 145)
    }

}

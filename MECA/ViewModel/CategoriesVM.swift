
import UIKit

class CategoriesVM: BaseCollectionViewVM {

    var arrCat = ["News RC","MEBIT","MaaS","HYDROGEN","SDGS","GR"]
    var arrcatImg = [UIImage.init(named: "News"),UIImage.init(named: "MEBIT"),UIImage.init(named: "MaaS"),UIImage.init(named: "Hydrogen"),UIImage.init(named: "SDGs"),UIImage.init(named: "GR")]

    
    override init(controller: UIViewController?) {
        super.init(controller: controller)
      actualController = controller

    }
    
    override func getItemForRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
    
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCategoryCollectionViewCell", for: indexPath) as! SelectCategoryCollectionViewCell
        cell.CategoryImageView.image = arrcatImg[indexPath.row]
        cell.CategoryLabel.text = arrCat[indexPath.row]
        return cell
    }
    func didSelectRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) {
        if indexPath.row == 0 {
            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "MEBITViewController") as! MEBITViewController
            vc.headerImageValue  = "0"
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1{
            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "MEBITViewController") as! MEBITViewController
            vc.headerImageValue  = "1"
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2{
            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "MEBITViewController") as! MEBITViewController
            vc.headerImageValue  = "2"
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 3{
            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "MEBITViewController") as! MEBITViewController
            vc.headerImageValue  = "3"
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 4{
            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "MEBITViewController") as! MEBITViewController
            vc.headerImageValue  = "4"
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 5{
            let story = UIStoryboard(name: "Category", bundle:nil)
                       let vc = story.instantiateViewController(withIdentifier: "MEBITViewController") as! MEBITViewController
            vc.headerImageValue  = "5"
            (actualController as! CategoriesViewController).navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    func getSizeForItem(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
        return CGSize(width: (actualController as! CategoriesViewController).screenWidth/2, height: 220)

    }
}

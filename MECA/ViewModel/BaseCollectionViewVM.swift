
import UIKit

class BaseCollectionViewVM: NSObject {
    
    var headerHeight:CGFloat = 36.0
    var identifierItem = "cell_item_class"
    var nibItem = "ClassItemCell"
    var actualController:UIViewController!
    var actualCell:UICollectionViewCell!
    var collectionItems:[Any] = [Any]()
    var sections:[String] = ["Hoy"]
    var baseHeaderCollectionViewHeight:CGFloat = 45
    //var headerView:BaseHeaderCollectionView!
    var identifierSuplementaryHeaderView = ""
    var nibSuplementaryHeaderView = ""
    init(controller:UIViewController?) {
        self.actualController = controller
       // nibSuplementaryHeaderView = "BaseHeaderCollectionView"
       // identifierSuplementaryHeaderView = "view_collection_header_base"
    }
    init(cell:UICollectionViewCell?) {
        self.actualCell = cell
  }
}
//Collection View Methord
extension BaseCollectionViewVM{

    @objc func getReferenceSizeForHeaderInSection(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: headerHeight)
    }
    
//    @objc func getViewForSupplementaryElementOfKind(_ kind:String, for collectionView:UICollectionView, for indexPath:IndexPath, withTitle title:String!)->UICollectionReusableView{
//        
//            switch kind {
//            case UICollectionView.elementKindSectionHeader:
////                headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifierSuplementaryHeaderView, for: indexPath) as? BaseHeaderCollectionView
//              //  headerView.setTitle(title.uppercased())
//                //headerView.btn_action.addTarget(self, action: #selector(btn_headerPressed(sender:)), for: .touchUpInside)
//            //    return headerView
//            default:
//                assert(false, "Unexpected element kind")
//            }
//
//        return headerView
//        
//    }
    @objc func btn_headerPressed(sender:UIButton){
        
    }
    @objc func getHeightForRowAt(_ indexPath:IndexPath)->CGFloat{
        return 0
    }
    
    @objc func getItemForRowAt(_ indexPath:IndexPath, collectionView:UICollectionView)->UICollectionViewCell{
        
        return UICollectionViewCell()
    }
    @objc func getNumbersOfItemsForSection(_ section:Int)->Int{
        return collectionItems.count
    }
    @objc func getNumbersOfSections()->Int{
        return sections.count
    }
    @objc func didSelectRowAt(_ indexPath:IndexPath){
        
    }

}

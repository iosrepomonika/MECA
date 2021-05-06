//
//  AddNewsVM.swift
//  MECA
//


import UIKit

class AddNewsVM: BaseCollectionViewVM {
    
    
    override init(controller: UIViewController?) {
        
        super.init(controller: controller)
      actualController = controller

    }
    
    override func getItemForRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
        cell.myImage.image = (actualController as! AddNewsViewController).ImageArray[indexPath.row]
        return cell
        
    }
    func didSelectRowAt(_ indexPath: IndexPath, collectionView: UICollectionView) {
        
    }
    
    func getSizeForItem(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: collectionView.frame.size.width / 2, height: 145)
    }

}

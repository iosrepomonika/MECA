

import UIKit

class PlusSelectCategoryVC: UIViewController {
    
    @IBOutlet weak var collectionSelectCategory: UICollectionView!
   
    var viewModel : PlusSelectCategoryVM!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PlusSelectCategoryVM.init(controller: self)
        self.collectionSelectCategory.register(UINib(nibName: "PlusSelectCategoryCVCell", bundle: nil), forCellWithReuseIdentifier: "PlusSelectCategoryCVCell")
        
    }
    
}

//MARK:- UIButton Action
extension PlusSelectCategoryVC {
    @IBAction func btnCrossAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK:- UICollectionView
extension PlusSelectCategoryVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrCat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.getItemForRowAt(indexPath, collectionView: collectionSelectCategory)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.getSizeForItem(collectionSelectCategory, collectionViewLayout: collectionViewLayout, indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath, collectionView: collectionSelectCategory)
        
    }
}

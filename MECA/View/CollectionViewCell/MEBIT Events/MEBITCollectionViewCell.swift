//
//  MEBITCollectionViewCell.swift
//  MECA
//
//
//

import UIKit

class MEBITCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bottomlabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "MEBITCollectionViewCell", bundle: nil)
    }

}

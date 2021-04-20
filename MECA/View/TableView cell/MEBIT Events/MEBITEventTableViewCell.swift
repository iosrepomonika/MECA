//
//  MEBITEventTableViewCell.swift
//  MECA
//
//
//

import UIKit

class MEBITEventTableViewCell: UITableViewCell {

    
    @IBOutlet weak var baseView: RCustomView!
    
    @IBOutlet weak var MebitImage: UIImageView!
    
    @IBOutlet weak var mebitTitlelbl: UILabel!
    
    @IBOutlet weak var mebitDatelbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        MebitImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        MebitImage.layer.cornerRadius = 16
    }
    static func nib() -> UINib {
        return UINib(nibName: "MEBITEventTableViewCell", bundle: nil)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

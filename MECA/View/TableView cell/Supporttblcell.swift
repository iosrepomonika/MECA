//
//  Supporttblcell.swift
//  MECA
//
//  Created by Macbook  on 10/05/21.
//

import UIKit

class Supporttblcell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var topView: RCustomView!
    
    
    
    @IBOutlet weak var supporttitleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.baseView.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 12.0, borderColor: UIColor.white, borderWidth: 1)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

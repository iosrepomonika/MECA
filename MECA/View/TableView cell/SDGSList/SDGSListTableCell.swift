//
//  SDGSListTableCell.swift
//  MECA
//
//  Created by Macbook  on 15/04/21.
//

import UIKit

class SDGSListTableCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var iconimgView: UIImageView!
    @IBOutlet weak var ArrowimgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addbtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

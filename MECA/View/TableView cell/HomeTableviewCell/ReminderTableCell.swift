//
//  ReminderTableCell.swift
//  MECA
//
//  Created by Macbook  on 11/05/21.
//

import UIKit

class ReminderTableCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var remindertitleLbl: UILabel!
    @IBOutlet weak var reminderdateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

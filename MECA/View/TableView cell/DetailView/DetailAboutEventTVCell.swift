//
//  DetailAboutEventTVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 20/04/21.
//

import UIKit

class DetailAboutEventTVCell: UITableViewCell {
    @IBOutlet weak var lblAboutEvent: UILabel!
    
    @IBOutlet weak var btnReadMoreOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib {
        return UINib(nibName: "DetailAboutEventTVCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setKaizenData(dataKaizen:KaizenInfoDataModel) {
        lblAboutEvent.text = dataKaizen.description
    }
    func setEventData(dataEvent:Data_Event) {
        lblAboutEvent.text = dataEvent.description

    }
}

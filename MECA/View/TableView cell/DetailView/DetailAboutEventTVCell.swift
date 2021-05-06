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
        if GlobalValue.tabCategory == "GR" {
            btnReadMoreOutlet.setTitleColor(#colorLiteral(red: 0.9882352941, green: 0, blue: 0, alpha: 1), for: .normal)
        }else if   GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            btnReadMoreOutlet.setTitleColor(#colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1), for: .normal)

        }else{
            btnReadMoreOutlet.setTitleColor(#colorLiteral(red: 0.9803921569, green: 0.6235294118, blue: 0.2039215686, alpha: 1), for: .normal)
        }
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
    
    func setGRData(grData:GRDetail_Data){
        lblAboutEvent.text = grData.description
    }
}

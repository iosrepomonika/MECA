

import UIKit

class DetailAboutEventTVCell: UITableViewCell {
    @IBOutlet weak var lblAboutEvent: UILabel!
    
    @IBOutlet weak var btnReadMoreOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if GlobalValue.tabCategory == "GR" {
            btnReadMoreOutlet.setTitleColor(UIColor.getCustomRedColor(), for: .normal)
        }else if   GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            btnReadMoreOutlet.setTitleColor(UIColor.getCustomBlueColor(), for: .normal)

        }else{
            btnReadMoreOutlet.setTitleColor(UIColor.getCustomOrangeColor(), for: .normal)
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

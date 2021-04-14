

import UIKit
import UIKit

protocol OrangeFooterViewDelegate{

    func footerBarAction1(strType : String)
}



class OrangeFooterView: UIView {

    @IBOutlet weak var imgWhatsnew: UIImageView!

    @IBOutlet weak var imgFromDistributor: UIImageView!
    @IBOutlet weak var imgFromTMC: UIImageView!
    let nibName = "OrangeFooterView"
    var contentView: UIView?
    var orangeFooterViewDelegate : OrangeFooterViewDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        view.frame = self.bounds

    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
        
    }
    
    @IBAction func btnTabAction(_ sender: UIButton) {
        if sender.tag == 10{
            orangeFooterViewDelegate.footerBarAction1(strType: "WhatsNew")
        }else if sender.tag == 20 {
            orangeFooterViewDelegate.footerBarAction1(strType: "FromDistributor")
        }else if sender.tag == 30 {
            orangeFooterViewDelegate.footerBarAction1(strType: "FromTMC")
        }
    }

}

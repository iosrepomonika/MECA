//
//  BlueFooterview.swift
//  MECA
//
//  Created by Macbook  on 15/04/21.
//

import UIKit
protocol BlueFooterViewDelegate{

    func footerBarAction1(strType : String)
}

class BlueFooterview: UIView {
    
    @IBOutlet weak var imgWhatsnew: UIImageView!

    @IBOutlet weak var imgFromDCategory: UIImageView!
    
    let nibName = "BlueFooterview"
    var contentView: UIView?
    var blueFooterViewDelegate : BlueFooterViewDelegate!
    
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
            blueFooterViewDelegate.footerBarAction1(strType: "WhatsNew")
        }else if sender.tag == 20 {
            blueFooterViewDelegate.footerBarAction1(strType: "Categories")
        }
    }

}

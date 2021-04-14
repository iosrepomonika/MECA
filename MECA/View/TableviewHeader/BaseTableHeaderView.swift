

import UIKit

class BaseTableHeaderView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var lbl_header: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //fromNib()
        setup()
    }
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    func setup() {
        UINib(nibName: "BaseTableHeaderView", bundle: nil)
            .instantiate(withOwner: self, options: nil)
        addSubview(view)

    }
    func setInfo(title:String, hint:String?, imageFilterButton:String?){
        setTitle(title)

    }
    func setTitle(_ title:String){
        lbl_header.text = title
}
}

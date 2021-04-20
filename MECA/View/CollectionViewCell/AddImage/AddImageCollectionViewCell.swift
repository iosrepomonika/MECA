

import UIKit

class AddImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var customView: UIView!
    
	@IBOutlet var removeButton: UIButton!
	@IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var playBtnRef: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

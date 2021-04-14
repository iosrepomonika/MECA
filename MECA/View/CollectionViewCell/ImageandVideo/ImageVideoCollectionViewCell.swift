
import UIKit

class ImageVideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var baseView: RCustomView!
    @IBOutlet weak var playBtnRef: UIButton!
    @IBOutlet weak var myImageView: RCustomImageView!
    
    var playVideo:(() -> ())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onClickPlay(_ sender: UIButton) {
        self.playVideo?()
    }
}

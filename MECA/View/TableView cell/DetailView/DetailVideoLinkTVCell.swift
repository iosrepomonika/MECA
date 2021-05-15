
import UIKit
import SDWebImage
import AVFoundation
import AVKit

class DetailVideoLinkTVCell: UITableViewCell {
    @IBOutlet weak var tblVIdeoLink: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
 
    @IBOutlet weak var seeMoreHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var seeMoreOutlet: UIButton!
    var arrVideoLink = [Video_links]()
  var arrKaizenVideo = [KaizenVideoLinkModel]()
  var isFrom = false
  var detailVC : NewDetailVC!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if GlobalValue.tabCategory == "GR"{
            seeMoreOutlet.setTitleColor(UIColor.getCustomRedColor(), for: .normal)
        }else if  GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            seeMoreOutlet.setTitleColor(UIColor.getCustomBlueColor(), for: .normal)
        }else{
            seeMoreOutlet.setTitleColor(UIColor.getCustomOrangeColor(), for: .normal)
        }
    }

    static func nib() -> UINib {
        return UINib(nibName: "DetailVideoLinkTVCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setEventData(dataEvent:Data_Event) {
        
        if dataEvent.video_links!.count > 0{
            isFrom = true
            if arrVideoLink.count>0{
                arrVideoLink.removeAll()
            }
            arrVideoLink = dataEvent.video_links!
            if arrVideoLink.count > 3{
                seeMoreHeightConstraint.constant = 30
                seeMoreOutlet.isHidden = false
              seeMoreOutlet.addTarget(self, action: #selector(self.SeeMoreAction), for: .touchUpInside)
        
                tblHeightConstraint.constant = CGFloat(154 * 3)

            }else{
                seeMoreHeightConstraint.constant = 0
                seeMoreOutlet.isHidden = true
                tblHeightConstraint.constant = CGFloat(154 * dataEvent.video_links!.count)

            }
            tblVIdeoLink.register(VideoLinkTableViewCell.nib(), forCellReuseIdentifier: "VideoLinkTableViewCell")
            tblVIdeoLink.delegate = self
            tblVIdeoLink.dataSource = self
           // tblHeightConstraint.constant = CGFloat(154*arrVideoLink.count)
            tblVIdeoLink.reloadData()
            detailVC.tblDetailView.beginUpdates()
            detailVC.tblDetailView.endUpdates()
        }
    }
    
    @objc func SeeMoreAction(sender: UIButton){
        if sender.isSelected{
            sender.isSelected = false
            sender.setTitle("See More", for: .normal)
            tblHeightConstraint.constant = CGFloat(154 * 3)
            tblVIdeoLink.reloadData()
            detailVC.tblDetailView.beginUpdates()
            detailVC.tblDetailView.endUpdates()
        }else {
            sender.isSelected = true
            sender.setTitle("Less", for: .normal)
            if arrVideoLink.count>0{
                tblHeightConstraint.constant = CGFloat(154 * arrVideoLink.count)
            }else if arrKaizenVideo.count>0{
                tblHeightConstraint.constant = CGFloat(154 * arrKaizenVideo.count)
            }
            tblVIdeoLink.reloadData()
            detailVC.tblDetailView.beginUpdates()
            detailVC.tblDetailView.endUpdates()

        }
    }
    func setKaizenData(dataKaizen:KaizenInfoDataModel) {
        isFrom = false
        if arrKaizenVideo.count>0{
            arrKaizenVideo.removeAll()
        }
        if dataKaizen.video_links!.count > 0{
            arrKaizenVideo = dataKaizen.video_links!
            if arrKaizenVideo.count > 3{
                seeMoreHeightConstraint.constant = 30
                seeMoreOutlet.isHidden = false
            seeMoreOutlet.addTarget(self, action: #selector(self.SeeMoreAction), for: .touchUpInside)
                tblHeightConstraint.constant = CGFloat(154 * 3)

            }else{
                seeMoreHeightConstraint.constant = 0
                seeMoreOutlet.isHidden = true
                tblHeightConstraint.constant = CGFloat(154 * dataKaizen.video_links!.count)

            }
            tblVIdeoLink.register(VideoLinkTableViewCell.nib(), forCellReuseIdentifier: "VideoLinkTableViewCell")
            tblVIdeoLink.delegate = self
            tblVIdeoLink.dataSource = self
          //  tblHeightConstraint.constant = CGFloat(154*arrKaizenVideo.count)
            tblVIdeoLink.reloadData()
            detailVC.tblDetailView.beginUpdates()
            detailVC.tblDetailView.endUpdates()
        }
    }
    func setGRData(grData:GRDetail_Data){
        
        if grData.video_links!.count > 0{
            isFrom = true
            if arrVideoLink.count>0{
                arrVideoLink.removeAll()
            }
            arrVideoLink = grData.video_links!
            if grData.video_links!.count > 0{
                arrVideoLink = grData.video_links!
                if arrVideoLink.count > 3{
                    seeMoreHeightConstraint.constant = 30
                    seeMoreOutlet.isHidden = false
                    seeMoreOutlet.addTarget(self, action: #selector(self.SeeMoreAction), for: .touchUpInside)
                    tblHeightConstraint.constant = CGFloat(154 * 3)
                    
                }else{
                    seeMoreHeightConstraint.constant = 0
                    seeMoreOutlet.isHidden = true
                    tblHeightConstraint.constant = CGFloat(154 * grData.video_links!.count)
                    
                }
                tblVIdeoLink.register(VideoLinkTableViewCell.nib(), forCellReuseIdentifier: "VideoLinkTableViewCell")
                tblVIdeoLink.delegate = self
                tblVIdeoLink.dataSource = self
                // tblHeightConstraint.constant = CGFloat(154*arrVideoLink.count)
                tblVIdeoLink.reloadData()
            }
        }
    }
}
extension DetailVideoLinkTVCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFrom{
            return arrVideoLink.count
        }else{
            return arrKaizenVideo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblVIdeoLink.dequeueReusableCell(withIdentifier: "VideoLinkTableViewCell", for: indexPath) as! VideoLinkTableViewCell
        if isFrom{
            cell.videoTitleLbl.text = arrVideoLink[indexPath.row].title
            cell.videoInfoLbl.text = arrVideoLink[indexPath.row].info
            cell.videoLinkLbl.text = arrVideoLink[indexPath.row].link
            let urlYoutube = arrVideoLink[indexPath.row].link
            let urlID = urlYoutube?.youtubeID
            let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
            let url = URL(string: urlStr)!
            cell.videoImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.videoImg.sd_setImage(with: url, completed: nil)
        }else{
            cell.videoTitleLbl.text = arrKaizenVideo[indexPath.row].title
            cell.videoInfoLbl.text = arrKaizenVideo[indexPath.row].info
            cell.videoLinkLbl.text = arrKaizenVideo[indexPath.row].link
            let urlYoutube = arrKaizenVideo[indexPath.row].link
            let urlID = urlYoutube?.youtubeID
            let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
            let url = URL(string: urlStr)!
            cell.videoImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.videoImg.sd_setImage(with: url, completed: nil)
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFrom{
            let obj = arrVideoLink[indexPath.row]
            if obj.link != ""{
                let objLink = (obj.link)!

                guard let url = URL(string: objLink) else { return }
                UIApplication.shared.open(url)
            }
        }else{
            let obj = arrKaizenVideo[indexPath.row]
            if obj.link != ""{
                let objLink = (obj.link)!

                guard let url = URL(string: objLink) else { return }
                UIApplication.shared.open(url)
            }
        }
    }
    
}

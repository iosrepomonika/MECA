//
//  VideoLinkVM.swift
//  MECA
//
//
//


import Foundation
import SDWebImage

import UIKit

class VideoLinkVM: BaseTableViewVM {
   
    let identifierItemCell = "VideoLinkTableViewCell"
  
    override init(controller: UIViewController?) {
        super.init(controller: controller)
       
    }
    override func getNumbersOfRows(in section: Int) -> Int {
        if (self.actualController as! VideoLinkVC).videoLinkValue == "0" {
            return (self.actualController as! VideoLinkVC).docLinkArr1.count
        }
        else {
            return (self.actualController as! VideoLinkVC).videoLinkArr1.count
        }
       
        
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierItemCell, for: indexPath) as! VideoLinkTableViewCell
        if (self.actualController as! VideoLinkVC).videoLinkValue == "0" {
            let obj = (self.actualController as! VideoLinkVC).docLinkArr1[indexPath.row]
            cell.videoView.isHidden = true
            cell.externalTitleLbl.text = obj["Title"] as? String
            cell.externalInfoLbl.text = obj["Info"] as? String
            cell.externalLinkLbl.text = obj["link"] as? String
        }
        else {
            let obj1 = (self.actualController as! VideoLinkVC).videoLinkArr1[indexPath.row]
            cell.externalView.isHidden = true
            cell.videoTitleLbl.text = obj1["Title"] as? String
            cell.videoInfoLbl.text = obj1["Info"] as? String
            cell.videoLinkLbl.text = obj1["link"] as? String
            let urlYoutube = obj1["link"] as? String
            let urlID = urlYoutube?.youtubeID
            let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
            let url = URL(string: urlStr)!
            cell.videoImg.sd_setImage(with: url, completed: nil)
        }
    
        return cell

    }
    
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        return 154
    }
   
}

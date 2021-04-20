//
//  DetailImagesAndVideosCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 20/04/21.
//

import UIKit
import SDWebImage
import AVFoundation
import AVKit
class DetailImagesAndVideosCell: UITableViewCell {
    @IBOutlet weak var btnSurveyLinkOutlet: UIButton!
    @IBOutlet weak var viewSurveyLink: UIView!
    @IBOutlet weak var videosCollectionView: UICollectionView!
    @IBOutlet weak var viewVIdeos: UIView!
    @IBOutlet weak var viewImages: UIView!
    @IBOutlet weak var imagesCollectionVIew: UICollectionView!
  
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var arrEventImg = [Event_videos]()
    var arrEventVideos = [Event_videos]()
    var detailVC : NewDetailVC!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
       // setUpUI()
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "DetailImagesAndVideosCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpUI()  {
        
       //self.imagesCollectionVIew.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")


        let layoutImg: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
        layoutImg.itemSize = CGSize(width: screenWidth/2, height: 120)
        layoutImg.minimumInteritemSpacing = 0
        layoutImg.minimumLineSpacing = 0
        layoutImg.scrollDirection = .horizontal
        imagesCollectionVIew!.collectionViewLayout = layoutImg
        imagesCollectionVIew.delegate = self
        imagesCollectionVIew.dataSource = self
        imagesCollectionVIew.reloadData()
        
        let layoutVideo: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
        layoutVideo.itemSize = CGSize(width: screenWidth/2, height: 120)
        layoutVideo.minimumInteritemSpacing = 0
        layoutVideo.minimumLineSpacing = 0
        layoutVideo.scrollDirection = .horizontal
        videosCollectionView!.collectionViewLayout = layoutVideo
        videosCollectionView.delegate = self
        videosCollectionView.dataSource = self
        videosCollectionView.reloadData()
    }
    func setKaizenData(dataKaizen:KaizenInfoDataModel) {
        viewSurveyLink.isHidden = true
        if dataKaizen.event_videos?.count == 0{
            viewVIdeos.isHidden = true
            
        }else{
            self.videosCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
            setUpUI()
            viewVIdeos.isHidden = false
            if arrEventVideos.count>0{
                arrEventVideos.removeAll()
            }
            arrEventVideos = dataKaizen.event_videos!
            videosCollectionView.reloadData()
            
        }
        
        if dataKaizen.event_images?.count == 0{
            viewImages.isHidden = true
        }else{
            self.imagesCollectionVIew.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
            setUpUI()
            viewImages.isHidden = false
            if arrEventImg.count>0{
                arrEventImg.removeAll()
            }
            arrEventImg = dataKaizen.event_images!
            imagesCollectionVIew.reloadData()
        }
    }
    func setEventData(dataEvent:Data_Event) {
        if dataEvent.survey_link == ""{
            viewSurveyLink.isHidden = true
        }else{
            viewSurveyLink.isHidden = false
            btnSurveyLinkOutlet.setTitle(dataEvent.survey_link, for: .normal)
        }
        
            if dataEvent.event_videos?.count == 0{
                viewVIdeos.isHidden = true
                
            }else{
                self.videosCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
                setUpUI()
                viewVIdeos.isHidden = false
                if arrEventVideos.count>0{
                    arrEventVideos.removeAll()
                }
                arrEventVideos = dataEvent.event_videos!
                videosCollectionView.reloadData()
                
            }
            if dataEvent.event_images?.count == 0{
                viewImages.isHidden = true
            }else{
                self.imagesCollectionVIew.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
                setUpUI()
                viewImages.isHidden = false
                if arrEventImg.count>0{
                    arrEventImg.removeAll()
                }
                arrEventImg = dataEvent.event_images!
                imagesCollectionVIew.reloadData()
            }
        }

    }

extension DetailImagesAndVideosCell:  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == videosCollectionView{
            return arrEventVideos.count
        }else{
            return arrEventImg.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == imagesCollectionVIew{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
            let objImage = arrEventImg[indexPath.row]
            if objImage.file != ""{
                let url = BaseURL + (objImage.file)!
                cell.myImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.myImageView.sd_setImage(with: URL(string:url), completed: nil)
            }else{
                cell.myImageView.image = UIImage(named: "image 1")
            }
            
            cell.playBtnRef.isHidden = true
            return cell
        }else{
            let cell1  = videosCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
            
            let objImage = arrEventVideos[indexPath.row]
            if objImage.file != ""{
                let urlimg = BaseURL + (objImage.file)!
                let url = URL(string: urlimg)!
                
                if let thumbnailImage = UtilesSwift.shared.getThumbnailImage(forUrl: url) {
                    cell1.myImageView.image = thumbnailImage
                }
            }
            
            
            cell1.playBtnRef.isHidden = false
            cell1.playVideo = {
                print("Video is atpped")
            }
            return cell1
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == imagesCollectionVIew) {
            print("Width: \(imagesCollectionVIew.frame.size.width / 2)")
            return CGSize(width: screenWidth/2, height: 120)
        }
        else if (collectionView == videosCollectionView) {
            print("Width: \(imagesCollectionVIew.frame.size.width / 2)")
            return CGSize(width: screenWidth/2, height: 120)
        }
        return CGSize()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == imagesCollectionVIew {
            let objImage = arrEventImg[indexPath.row]
            if objImage.file != ""{
                let url = BaseURL + (objImage.file)!
                detailVC.viewImgPreview.isHidden = false
                detailVC.imgPreview.sd_setImage(with: URL(string:url), completed: nil)
            }else{
                detailVC.imgPreview.image = UIImage(named: "image 1")
            }
        }else{
            let obj = arrEventVideos[indexPath.row]
            if obj.file != ""{
                let urlimg = BaseURL + (obj.file)!

            guard let videoURL = URL(string: urlimg) else {
                      return
                }
                let player = AVPlayer(url: videoURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                detailVC.present(playerViewController, animated: true) {
                  playerViewController.player?.play()
                }
            }
        }
    }
}

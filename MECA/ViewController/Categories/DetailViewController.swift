

import UIKit
import SDWebImage
import AVFoundation
import AVKit

class DetailViewController: UIViewController {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var DismissRefBtn: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var toyota2021TitleLabel: UILabel!
    @IBOutlet weak var separatorLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startView: RCustomView!
    @IBOutlet weak var dateIcon: UIImageView!
    @IBOutlet weak var eventStartDateLabel: UILabel!
    @IBOutlet weak var eventStartDayLabel: UILabel!
    @IBOutlet weak var timeIcon: UIImageView!
    @IBOutlet weak var eventStartTimeLabel: UILabel!
    @IBOutlet weak var eventStartTime2Label: UILabel!
    @IBOutlet weak var endView: RCustomView!
    @IBOutlet weak var endDateIcon: UIImageView!
    @IBOutlet weak var eventEndDateLabel: UILabel!
    @IBOutlet weak var eventEndDaylabel: UILabel!
    @IBOutlet weak var endTimeIcon: UIImageView!
    @IBOutlet weak var eventEndTimeLabel: UILabel!
    @IBOutlet weak var eventEndTime2Label: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: RCustomView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var aboutEventLabel: UILabel!
    @IBOutlet weak var eventSubTitleLabel: UILabel!
    @IBOutlet weak var readMoreRefBtn: UIButton!
    @IBOutlet weak var imageandVideoView: UIView!
    @IBOutlet weak var surveyLinkLabel: UILabel!
    @IBOutlet weak var surveyLinkRefBtn: UIButton!
    @IBOutlet weak var imagelabelRef: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var videoTitleRef: UILabel!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var eventContentsLabel: UILabel!
    @IBOutlet weak var presentation1TextField: UITextField!
    @IBOutlet weak var downloadDoc1RefBtn: UIButton!
    @IBOutlet weak var presentation2TextField: UITextField!
    @IBOutlet weak var downloadDoc2RefBtn: UIButton!
    @IBOutlet weak var videoLinklabel: UILabel!
    @IBOutlet weak var videoLinkRefBtn: UIButton!
    @IBOutlet weak var CommentsLikeView: UIView!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentIcon: UIImageView!
    @IBOutlet weak var commentlabel: UILabel!
    @IBOutlet weak var likeBtnRef: UIButton!
    @IBOutlet weak var commentBtnRef: UIButton!
    @IBOutlet weak var separatorlabel3: UILabel!
    
    @IBOutlet weak var viewSurvayLinkHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewImagCollection: UIView!
    @IBOutlet weak var viewImgCollectHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewVideoCollection: UIView!
   
    @IBOutlet weak var viewViideoHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var locationviewHeightConstraint: NSLayoutConstraint!
 
    @IBOutlet weak var viewLinkTopContraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewImgTopConstrint: NSLayoutConstraint!
    @IBOutlet weak var viewVideoTopCOnstrint: NSLayoutConstraint!
    
    var navValue = ""
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var eventID = ""
	var isEvent = false

    var arrcatImg = [UIImage.init(named: "News"),UIImage.init(named: "MEBIT"),UIImage.init(named: "MaaS"),UIImage.init(named: "Hydrogen"),UIImage.init(named: "SDGs"),UIImage.init(named: "GR")]
    
    
    
    //Api Array
    var viewModel : EventInfoVM!
    var viewModel1 : KaizenVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
//        imageCollectionView.dataSource = self
//        imageCollectionView.delegate = self
       
//        self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
//        videoCollectionView.dataSource = self
//        videoCollectionView.delegate = self
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        setupUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navValue == "0" {
            //rootVC : Home vc
            print("From Home VC")
            if isEvent
            {
                self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                viewModel = EventInfoVM.init(controller: self)
                viewModel.callEventInfoWebservice()
                
            }
            else
            {
                viewModel1 = KaizenVM.init(controller: self)
                viewModel1.callKaizenInfoWebservice { (info) in
                    if info == true{
                        if self.viewModel1.arrEventImg.count>0{
                            self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
                            
                            self.setupUI()
                            self.imageCollectionView.delegate = self
                            self.imageCollectionView.dataSource = self
                            self.imageCollectionView.reloadData()
                        }
                        
                        if self.viewModel1.arrEventVideos.count>0{
                            self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
                            self.videoCollectionView.dataSource = self
                            self.videoCollectionView.delegate = self
                            self.videoCollectionView.delegate = self
                            self.videoCollectionView.dataSource = self
                            self.videoCollectionView.reloadData()
                        }
                    }
                }
            }
            
        }
        else if navValue == "1" {
            //root VC : MEBIT VC
         
            if isEvent
            {
                self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")
                
                viewModel = EventInfoVM.init(controller: self)
                viewModel.callEventInfoWebservice()
            }
            else
            {
                viewModel1 = KaizenVM.init(controller: self)
                viewModel1.callKaizenInfoWebservice { (info) in
                    if info == true{
                        if self.viewModel1.arrEventImg.count>0{
                            self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                            self.imageCollectionView.delegate = self
                            self.imageCollectionView.dataSource = self
                            self.imageCollectionView.reloadData()
                        }
                        
                        if self.viewModel1.arrEventVideos.count>0{
                            self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                            self.videoCollectionView.delegate = self
                            self.videoCollectionView.dataSource = self
                            self.videoCollectionView.reloadData()
                        }
                    }
                }
            }
        }else{
            viewModel1 = KaizenVM.init(controller: self)
            viewModel1.callKaizenInfoWebservice { (info) in
                if info == true{
                    if self.viewModel1.arrEventImg.count>0{
                        self.imageCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                        self.imageCollectionView.delegate = self
                        self.imageCollectionView.dataSource = self
                        self.imageCollectionView.reloadData()
                    }
                    
                    if self.viewModel1.arrEventVideos.count>0{
                        self.videoCollectionView.register(UINib(nibName: "ImageVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageVideoCollectionViewCell")

                        self.videoCollectionView.delegate = self
                        self.videoCollectionView.dataSource = self
                        self.videoCollectionView.reloadData()
                    }
                }        }
            
            
        }
    }

    func setupUI() {
        presentation1TextField.layer.borderWidth = 1
        presentation1TextField.layer.borderColor = #colorLiteral(red: 0.9803921569, green: 0.6235294118, blue: 0.2039215686, alpha: 1)
        presentation1TextField.layer.cornerRadius = 4
        presentation2TextField.layer.borderWidth = 1
        presentation2TextField.layer.borderColor = #colorLiteral(red: 0.9803921569, green: 0.6235294118, blue: 0.2039215686, alpha: 1)
        presentation2TextField.layer.cornerRadius = 4
        likeBtnRef.layer.cornerRadius = 15
        commentBtnRef.layer.cornerRadius = 15
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
        layout.itemSize = CGSize(width: screenWidth/2, height: 120)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        imageCollectionView!.collectionViewLayout = layout
        videoCollectionView!.collectionViewLayout = layout

        videoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
   

    
    
    @IBAction func onClickDismissVC(_ sender: UIButton) {
       // self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func onClickReadMore(_ sender: UIButton) {
        if isEvent
        {
        if viewModel.strdescription != ""{
            let vc = FlowController().instantiateViewController(identifier: "AboutDetailVC", storyBoard: "Category") as! AboutDetailVC
            vc.strdescrtiption = viewModel.strdescription
            //vc.navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true, completion: nil)
            
        }
        }else{
            if viewModel1.strdescription != ""{
                let vc = FlowController().instantiateViewController(identifier: "AboutDetailVC", storyBoard: "Category") as! AboutDetailVC
                vc.strdescrtiption = viewModel1.strdescription
                //vc.navigationController?.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .fullScreen

                self.present(vc, animated: true, completion: nil)
                
            }
        }
    }
   
    
    
    @IBAction func onClickSurveyLink(_ sender: UIButton) {
    }
    
    @IBAction func onClickDownloadDoc1(_ sender: UIButton) {
    }
    
    @IBAction func onClickDownloadDov2(_ sender: UIButton) {
    }
    
    
    @IBAction func onClickVideoLink(_ sender: UIButton) {
    }
    
    @IBAction func onClickLike(_ sender: UIButton) {
    }
    
    @IBAction func onClickComment(_ sender: UIButton) {
    }
    
}
//MARK:- UICollectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if navValue == "0" {
            //rootVC : Home vc
            if isEvent
            {
                if collectionView == imageCollectionView{
                    return viewModel.arrEventImg.count
                }else{
                    return viewModel.arrEventVideos.count
                }
                
            }
            else
            {
                if collectionView == imageCollectionView{
                    return viewModel1.arrEventImg.count
                }else{
                    return viewModel1.arrEventVideos.count
                }
            }

        }
        else if navValue == "1" {
            //root VC : MEBIT VC
            if isEvent
            {
                if collectionView == imageCollectionView{
                    return viewModel.arrEventImg.count
                }else{
                    return viewModel.arrEventVideos.count
                }
                
            }
            else
            {
                if collectionView == imageCollectionView{
                    return viewModel1.arrEventImg.count
                }else{
                    return viewModel1.arrEventVideos.count
                }
            }
        }else{
            if collectionView == imageCollectionView{
                return viewModel1.arrEventImg.count
            }else{
                return viewModel1.arrEventVideos.count
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if navValue == "0" {
            if isEvent{
                
                if (collectionView == imageCollectionView) {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    cell.isHidden = false
                    let objImage = viewModel.arrEventImg[indexPath.row]
                    if objImage.file != ""{
                        let url = BaseURL + (objImage.file)!
                        cell.myImageView.sd_setImage(with: URL(string:url), completed: nil)
                    }else{
                        cell.myImageView.image = UIImage(named: "image 1")
                    }
                    
                    cell.playBtnRef.isHidden = true
                    return cell
                }
                else if (collectionView == videoCollectionView) {
                    let cell1  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    
                    let objImage = viewModel.arrEventVideos[indexPath.row]
                    if objImage.file != ""{
                        let urlimg = BaseURL + (objImage.file)!
                        let url = URL(string: urlimg)!
                        
                        if let thumbnailImage = getThumbnailImage(forUrl: url) {
                            cell1.myImageView.image = thumbnailImage
                        }
                    }
                    
                    
                    cell1.playBtnRef.isHidden = false
                    cell1.playVideo = {
                        print("Video is atpped")
                    }
                    return cell1
                }
            }else{
                
                if (collectionView == imageCollectionView) {
                    let cell  = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    let objImage = viewModel1.arrEventImg[indexPath.row]
                    if objImage.file != ""{
                        let url = BaseURL + (objImage.file)!
                        cell.myImageView.sd_setImage(with: URL(string:url), completed: nil)
                    }else{
                        cell.myImageView.image = UIImage(named: "image 1")
                    }
                    
                    cell.playBtnRef.isHidden = true
                    return cell
                }
                else if (collectionView == videoCollectionView) {
                    let cell1  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    let objImage = viewModel1.arrEventVideos[indexPath.row]
                    cell1.playBtnRef.isHidden = false
                    if objImage.file != ""{
                        let urlimg = BaseURL + (objImage.file)!
                        let url = URL(string: urlimg)!
                        
                        if let thumbnailImage = getThumbnailImage(forUrl: url) {
                            cell1.myImageView.image = thumbnailImage
                        }
                    }
                    cell1.playVideo = {
                        print("Video is atpped")
                    }
                    return cell1
                }
            }
        }else if navValue == "1"{
            if isEvent{
                
                if (collectionView == imageCollectionView) {
                    let cell  = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    let objImage = viewModel.arrEventImg[indexPath.row]
                    if objImage.file != ""{
                        let url = BaseURL + (objImage.file)!
                        cell.myImageView.sd_setImage(with: URL(string:url), completed: nil)
                    }else{
                        cell.myImageView.image = UIImage(named: "image 1")
                    }
                    cell.playBtnRef.isHidden = true
                    return cell
                }
                else if (collectionView == videoCollectionView) {
                    let cell1  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    let objImage = viewModel.arrEventVideos[indexPath.row]
                    if objImage.file != ""{
                        let urlimg = BaseURL + (objImage.file)!
                        let url = URL(string: urlimg)!
                        
                        if let thumbnailImage = getThumbnailImage(forUrl: url) {
                            cell1.myImageView.image = thumbnailImage
                        }
                    }
                    cell1.playBtnRef.isHidden = false
                    cell1.playVideo = {
                        print("Video is atpped")
                    }
                    return cell1
                }
            }else{
                
                if (collectionView == imageCollectionView) {
                    let cell  = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    // cell.myImageView.image = arrcatImg[indexPath.row]
                    cell.myImageView.image = UIImage(named: "image 1")
                    cell.playBtnRef.isHidden = true
                    return cell
                }
                else if (collectionView == videoCollectionView) {
                    let cell1  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                    cell1.myImageView.image = UIImage(named: "image 2")
                    cell1.playBtnRef.isHidden = false
                    cell1.playVideo = {
                        print("Video is atpped")
                    }
                    return cell1
                }
            }
        }else{
            
            if (collectionView == imageCollectionView) {
                let cell  = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                // cell.myImageView.image = arrcatImg[indexPath.row]
                cell.myImageView.image = UIImage(named: "image 1")
                cell.playBtnRef.isHidden = true
                return cell
            }
            else if (collectionView == videoCollectionView) {
                let cell1  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageVideoCollectionViewCell", for: indexPath) as! ImageVideoCollectionViewCell
                let objImage = viewModel1.arrEventVideos[indexPath.row]
                if objImage.file != ""{
                    let urlimg = BaseURL + (objImage.file)!
                    let url = URL(string: urlimg)!
                    
                    if let thumbnailImage = getThumbnailImage(forUrl: url) {
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
        
        return UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if navValue == "0" {
            if isEvent{
                
                if (collectionView == imageCollectionView) {
                  
                }
                else if (collectionView == videoCollectionView) {
                    let obj = viewModel.arrEventVideos[indexPath.row]
                    if obj.file != ""{
                        let urlimg = BaseURL + (obj.file)!

                    guard let videoURL = URL(string: urlimg) else {
                              return
                        }
                        let player = AVPlayer(url: videoURL)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        self.present(playerViewController, animated: true) {
                          playerViewController.player?.play()
                        }
                    }
                   
                }
            }else{
                
                if (collectionView == imageCollectionView) {
                    
                }
                else if (collectionView == videoCollectionView) {
                    let obj = viewModel1.arrEventVideos[indexPath.row]
                    if obj.file != ""{
                        let urlimg = BaseURL + (obj.file)!

                    guard let videoURL = URL(string: urlimg) else {
                              return
                        }
                        let player = AVPlayer(url: videoURL)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        self.present(playerViewController, animated: true) {
                          playerViewController.player?.play()
                        }
                    }
                }
            }
        }else if navValue == "1"{
            if isEvent{
                
                if (collectionView == imageCollectionView) {
                    
                }
                else if (collectionView == videoCollectionView) {
                    let obj = viewModel.arrEventVideos[indexPath.row]
                    if obj.file != ""{
                        let urlimg = BaseURL + (obj.file)!

                    guard let videoURL = URL(string: urlimg) else {
                              return
                        }
                        let player = AVPlayer(url: videoURL)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        self.present(playerViewController, animated: true) {
                          playerViewController.player?.play()
                        }
                    }
                   
                }
            }else{
                
                if (collectionView == imageCollectionView) {
                   
                }
                else if (collectionView == videoCollectionView) {
                    let obj = viewModel1.arrEventVideos[indexPath.row]
                    if obj.file != ""{
                        let urlimg = BaseURL + (obj.file)!

                    guard let videoURL = URL(string: urlimg) else {
                              return
                        }
                        let player = AVPlayer(url: videoURL)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        self.present(playerViewController, animated: true) {
                          playerViewController.player?.play()
                        }
                    }
                }
            }
        }else{
            
            if (collectionView == imageCollectionView) {
                let obj = viewModel1.arrEventVideos[indexPath.row]
                if obj.file != ""{
                    let urlimg = BaseURL + (obj.file)!

                guard let videoURL = URL(string: urlimg) else {
                          return
                    }
                    let player = AVPlayer(url: videoURL)
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    self.present(playerViewController, animated: true) {
                      playerViewController.player?.play()
                    }
                }
               
            }
            else if (collectionView == videoCollectionView) {
                let obj = viewModel1.arrEventVideos[indexPath.row]
                if obj.file != ""{
                    let urlimg = BaseURL + (obj.file)!

                guard let videoURL = URL(string: urlimg) else {
                          return
                    }
                    let player = AVPlayer(url: videoURL)
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    self.present(playerViewController, animated: true) {
                      playerViewController.player?.play()
                    }
                }
            }
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == imageCollectionView) {
            print("Width: \(imageCollectionView.frame.size.width / 2)")
            return CGSize(width: screenWidth/2, height: 120)
        }
        else if (collectionView == videoCollectionView) {
            print("Width: \(videoCollectionView.frame.size.width / 2)")
            return CGSize(width: screenWidth/2, height: 120)
        }
        return CGSize()
        
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }
}

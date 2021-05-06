
import UIKit
import Photos
import BSImagePicker
import MobileCoreServices
import AVFoundation
import Alamofire
import PDFKit
class CategoryCommonViewController: UIViewController {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var dismissVCRefBtn: UIButton!
    @IBOutlet weak var dismissVC2RefBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabelRef: UILabel!
    @IBOutlet weak var titleInputTextField: UITextField!
    @IBOutlet weak var startDateRef: UILabel!
    @IBOutlet weak var endDateLabelRef: UILabel!
    @IBOutlet weak var seperatorLabelRef: UILabel!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var typeLabelRef: UILabel!
    @IBOutlet weak var chooseTypeTextField: UITextField!
    @IBOutlet weak var descriptionLabelRef: UILabel!
    @IBOutlet weak var DescriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var coverLabelRef: UILabel!
    @IBOutlet weak var addImageRefBtn: UIButton!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var imagesLabelRef: UILabel!
    @IBOutlet weak var addImagesVideosRefBtn: UIButton!
    @IBOutlet weak var documentsLabelRef: UILabel!
    @IBOutlet weak var addFileRefBtn: UIButton!
    @IBOutlet weak var externalLinkLabelRef: UILabel!
    @IBOutlet weak var externalLinkTextField: UITextField!
    @IBOutlet weak var videoLinkLabelRef: UILabel!
    @IBOutlet weak var VideoLinkTextField: UITextField!
    @IBOutlet weak var addRefBtn: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageandVideoCollectionView: UICollectionView!
    @IBOutlet weak var heightConstarint2: NSLayoutConstraint!
    @IBOutlet weak var documentCollectionView: UICollectionView!
    @IBOutlet weak var heightConstarint3: NSLayoutConstraint!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var heightConstarint4: NSLayoutConstraint!
    
    @IBOutlet weak var externalLinkVIewOne: RCustomView!
    @IBOutlet weak var externalLinkViewTwo: RCustomView!
    @IBOutlet weak var rxternalLinkStackTOpContraint: NSLayoutConstraint!
    
    @IBOutlet weak var externalLinkTitle1: UILabel!
    @IBOutlet weak var externalLinkInfo1: UILabel!
    @IBOutlet weak var externalLink1: UILabel!
    
    @IBOutlet weak var externalLinkTitle2: UILabel!
    @IBOutlet weak var externalLinkInfo2: UILabel!
    @IBOutlet weak var externalLink2: UILabel!

  
    
    @IBOutlet weak var videoLinkVIewOne: RCustomView!
    @IBOutlet weak var videoLinkViewTwo: RCustomView!
    @IBOutlet weak var videoLinkStackTOpContraint: NSLayoutConstraint!
    
    @IBOutlet weak var videoLinkTitle1: UILabel!
    @IBOutlet weak var videoLinkInfo1: UILabel!
    @IBOutlet weak var videoLink1: UILabel!
    @IBOutlet weak var videoLinkImg1: UIImageView!
    
    @IBOutlet weak var videoLinkTitle2: UILabel!
    @IBOutlet weak var videoLinkInfo2: UILabel!
    @IBOutlet weak var videoLink2: UILabel!
    @IBOutlet weak var videoLinkImg2: UIImageView!

   
    
    @IBOutlet weak var externalbtnOutletSeeMore: UIButton!
   
    @IBOutlet weak var externalLinkStackviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoLinkbtnOutletSeeMore: UIButton!
    @IBOutlet weak var videoLinkStackviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewAlertAddLinks: UIView!
    @IBOutlet weak var txtviewPopopInfo: UITextView!
    @IBOutlet weak var txtPopupTitle: UITextField!
  
 
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var myTitle = ""
    var coverImageArr = [UIImage]()
    var imageVideoArray = [String]()
    var DocumentArray = [UIImage]()
    var viewModel : CreateKaizenVM!
    var mutipleImageArr = [UIImage]()
    var SelectedAssests = [PHAsset]()
    var imageAndVideoValue = ""
    var videoArr = [URL]()
    var thumbNailImageArr = [UIImage]()
    var imageValue = ""
    var arrimages : [Data] = []
    var arrvideos : [Data] = []
    var arrDoc : [Data] = []
    var arrCoverimage : [Data] = []
    let datePicker = UIDatePicker()
    let thePicker = UIPickerView()
    var isAddLink = ""
    var videoLinkArr = [[String:Any]]()
    var docLinkArr = [[String:Any]]()

    
    let typePickerData = [String](arrayLiteral: "New Car Sales", "After Sales", "Trade In", "BIT Foundation")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateKaizenVM.init(controller: self)
        
        registerNib()
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        setupCollectionView()
        setupCollectionView1()
        setupCollectionView2()
        setupCollectionView4()
        setupCollectionView5()
        setupUI()
        chooseTypeTextField.inputView = thePicker
        thePicker.delegate = self
        startDateTextField.setInputViewDatePicker(target: self, selector: #selector(startDatetapDone)) //1
        endDateTextField.setInputViewDatePicker(target: self, selector: #selector(endDatetapDone)) //1
    }
    
    func registerNib() {
        
        self.photoCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        self.imageandVideoCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        imageandVideoCollectionView.dataSource = self
        imageandVideoCollectionView.delegate = self
        
        self.documentCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        documentCollectionView.dataSource = self
        documentCollectionView.delegate = self
        
        self.videoCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionView()
        setupCollectionView1()
        setupCollectionView2()
        setupCollectionView4()
        setupCollectionView5()
    }
    func setupUI(){
        titleInputTextField.layer.borderWidth = 1
        titleInputTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        titleInputTextField.layer.cornerRadius = 8
        startDateTextField.layer.borderWidth = 1
        startDateTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        startDateTextField.layer.cornerRadius = 8
        endDateTextField.layer.borderWidth = 1
        endDateTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        endDateTextField.layer.cornerRadius = 8
        chooseTypeTextField.layer.borderWidth = 1
        chooseTypeTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        chooseTypeTextField.layer.cornerRadius = 8
        externalLinkTextField.layer.borderWidth = 1
        externalLinkTextField.layer.borderColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        externalLinkTextField.layer.cornerRadius = 8
        VideoLinkTextField.layer.borderWidth = 1
        VideoLinkTextField.layer.borderColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        VideoLinkTextField.layer.cornerRadius = 8
        DescriptionView.layer.cornerRadius = 8
        descriptionTextView.layer.cornerRadius = 8
        addImageRefBtn.layer.borderWidth = 1
        addImageRefBtn.layer.cornerRadius = 8
        addImageRefBtn.layer.borderColor  = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        addImagesVideosRefBtn.layer.borderWidth = 1
        addImagesVideosRefBtn.layer.cornerRadius = 8
        addImagesVideosRefBtn.layer.borderColor  = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        addFileRefBtn.layer.borderWidth = 1
        addFileRefBtn.layer.cornerRadius = 8
        addFileRefBtn.layer.borderColor  = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        addRefBtn.layer.borderWidth = 1
        addRefBtn.layer.cornerRadius = 16
        addRefBtn.layer.borderColor  = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        titleLabel.text = myTitle
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: screenWidth/2, height: 70)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        photoCollectionView!.collectionViewLayout = layout
        
        imageandVideoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout2.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout2.itemSize = CGSize(width: screenWidth/2, height: 70)
        layout2.minimumInteritemSpacing = 0
        layout2.minimumLineSpacing = 0
        layout2.scrollDirection = .horizontal
        imageandVideoCollectionView!.collectionViewLayout = layout2
        
        videoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let layout3: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout3.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout3.itemSize = CGSize(width: screenWidth/2, height: 70)
        layout3.minimumInteritemSpacing = 0
        layout3.minimumLineSpacing = 0
        layout3.scrollDirection = .horizontal
        videoCollectionView!.collectionViewLayout = layout3
        
        documentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let layout4: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout4.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout4.itemSize = CGSize(width: screenWidth/2, height: 70)
        layout4.minimumInteritemSpacing = 0
        layout4.minimumLineSpacing = 0
        layout4.scrollDirection = .horizontal
        documentCollectionView!.collectionViewLayout = layout4
        
        
      
         rxternalLinkStackTOpContraint.constant = 0
        externalLinkVIewOne.isHidden = true
        externalLinkViewTwo.isHidden = true
        externalbtnOutletSeeMore.isHidden = true
        externalLinkStackviewHeightConstraint.constant = 0
        videoLinkViewTwo.isHidden = true
        videoLinkVIewOne.isHidden = true
        videoLinkStackTOpContraint.constant = 0
        videoLinkbtnOutletSeeMore.isHidden = true
        videoLinkStackviewHeightConstraint.constant = 0
        viewAlertAddLinks.isHidden = true
        
        
    }
    
    func setupCollectionView() {
        if coverImageArr.isEmpty {
            heightConstraint.constant = 0
            photoCollectionView.reloadData()
            print("No data")
            
        }
        else {
            heightConstraint.constant = 70
            photoCollectionView.reloadData()
            print("has data")
        }
        
    }
    
    func setupCollectionView1() {
        
        if mutipleImageArr.isEmpty  {
            heightConstarint2.constant = 0
            print("No multiple iamges")
            
        }
        else {
            heightConstarint2.constant = 70
            print(" having multiple iamges")
        }

		DispatchQueue.main.async {
			self.imageandVideoCollectionView.reloadData()

		}
        
    }
    func setupCollectionView2() {
        if DocumentArray.isEmpty {
            heightConstarint3.constant = 0
            documentCollectionView.reloadData()
            
        }
        else {
            heightConstarint3.constant = 70
            documentCollectionView.reloadData()
        }
        
    }
    func setupCollectionView4(){
        if mutipleImageArr.isEmpty && thumbNailImageArr.isEmpty {
            heightConstarint2.constant = 0
            imageandVideoCollectionView.reloadData()
            print("Type 4 no data")
        }
        else {
            heightConstarint2.constant = 70
            imageandVideoCollectionView.reloadData()
            print("Type 4 has data")
        }
        
        
    }
    
    func setupCollectionView5()
    {
        
        if thumbNailImageArr.isEmpty {
            heightConstarint4.constant = 0
            videoCollectionView.reloadData()
        }
        else {
            heightConstarint4.constant = 70
            videoCollectionView.reloadData()
        }
        
    }
    
    @IBAction func onClickDismissVC(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickDismissVC2(_ sender: UIButton) {
        let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = mainVC
        appDel.window?.makeKeyAndVisible()
    }
    
    @IBAction func onClickAddImage(_ sender: UIButton) {
        
        
        
        if coverImageArr.isEmpty {
            self.presentPhotoActionSheet()
        }
        else {
            let alert1 = UIAlertController(title: "Can't Add more!", message: "You cannot add more than one Cover Image", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert1.addAction(dismiss)
            present(alert1, animated: true, completion: nil)
            
        }
       
    }
    
    @IBAction func onClickAddImageandVideo(_ sender: UIButton) {
        self.pickImageandVideo()
    }
    
    
    
    @IBAction func onClickAddFile(_ sender: UIButton) {
        //
        let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)

    }
    
    @IBAction func onClickAdddData(_ sender: UIButton) {
        createKaizen()
    }
    func convertAssetToImages() -> Void {
        
        if SelectedAssests.count != 0{
            
            if mutipleImageArr.count > 0 {
                mutipleImageArr.removeAll()
                
            }
            for i in 0..<SelectedAssests.count{
                
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                
                
                manager.requestImage(for: SelectedAssests[i], targetSize: CGSize(width: screenWidth/2, height: 70), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                    
                })
                
                let data = thumbnail.jpegData(compressionQuality: 0.7)
                arrimages.append(data!)
                let newImage = UIImage(data: data!)

                
                self.mutipleImageArr.append(newImage! as UIImage)
                setupCollectionView1()

				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
					self.imageandVideoCollectionView.reloadData()
				}

            }
            
        }
        
        print("complete photo array \(self.mutipleImageArr)")
        setupCollectionView()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.reloadData()

		DispatchQueue.main.async {
			self.imageandVideoCollectionView.reloadData()
		}
        
    }
    @IBAction func btnAddLinksAction(_ sender: UIButton) {
        if sender.tag == 10 {
            if externalLinkTextField.text.unsafelyUnwrapped.isEmpty {
                let alert1 = UIAlertController(title: "Alert!", message: "External Link Cant be empty", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert1.addAction(dismiss)
                present(alert1, animated: true, completion: nil)
            }
            
            
         else  if externalLinkTextField.text.unsafelyUnwrapped.contains("http") {
                print("exists")
            txtPopupTitle.text = ""
            txtviewPopopInfo.text = ""
            isAddLink = "External"
            viewAlertAddLinks.isHidden = false


            }else  {
                print("INValid Youtube URL")
                let alert1 = UIAlertController(title: "Invalid URL!", message: "Please Check Enter URL", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert1.addAction(dismiss)
                present(alert1, animated: true, completion: nil)
            }

        }else{
            
            if VideoLinkTextField.text.unsafelyUnwrapped.isEmpty {
                let alert1 = UIAlertController(title: "Alert!", message: "Video Link Cant be empty", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert1.addAction(dismiss)
                present(alert1, animated: true, completion: nil)
            }
            
            
         else  if VideoLinkTextField.text.unsafelyUnwrapped.contains("https://www.youtube.com/") ||   VideoLinkTextField.text.unsafelyUnwrapped.contains("https://youtu") {
                print("exists")
            txtPopupTitle.text = ""
            txtviewPopopInfo.text = ""
            isAddLink = "Video"
            viewAlertAddLinks.isHidden = false

           
            }
            else  {
                print("INValid Youtube URL")
                let alert1 = UIAlertController(title: "Invalid URL", message: "Please Check Enter URL", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert1.addAction(dismiss)
                present(alert1, animated: true, completion: nil)
            }

        }
    }
    @IBAction func btnSeeMoreAction(_ sender: UIButton) {
        if sender.tag == 10 {
            //external link
            let VC = FlowController().instantiateViewController(identifier: "VideoLinkVC", storyBoard: "Home") as!  VideoLinkVC
            VC.videoLinkValue = "0"
            VC.docLinkArr1 = docLinkArr
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
        
        }else{
           //video link
            let VC = FlowController().instantiateViewController(identifier: "VideoLinkVC", storyBoard: "Home") as! VideoLinkVC
            VC.videoLinkValue = "1"
            VC.videoLinkArr1 = videoLinkArr
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
        }
    }
 
    @IBAction func popUpbtnAction(_ sender: UIButton) {
        if sender.tag == 10 {
            viewAlertAddLinks.isHidden = true
            //Close
        }else{
            //Submit
            if isAddLink == "Video"{
                //video
                if txtPopupTitle.text == "" && txtviewPopopInfo.text == "" {
                    let alert1 = UIAlertController(title: "Alert!", message: "Please Enter all Details", preferredStyle: .alert)
                    let dismiss = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    alert1.addAction(dismiss)
                    present(alert1, animated: true, completion: nil)
                }
                else {
                    let dict:[String:Any] = ["link": "\(VideoLinkTextField.text.unsafelyUnwrapped)",
                                             "title": "\(txtPopupTitle.text.unsafelyUnwrapped)",
                                             "info":"\(txtviewPopopInfo.text.unsafelyUnwrapped)"]
                    videoLinkArr.append(dict)
                    print("Data Added \(videoLinkArr)")
                    for i in 0..<videoLinkArr.count {
                        let obj = videoLinkArr[i]
                        if i == 0{
                            videoLinkStackTOpContraint.constant = 16
                           videoLinkVIewOne.isHidden = false
                           videoLinkStackviewHeightConstraint.constant = 130
                            videoLinkTitle1.text = obj["title"] as? String
                            videoLinkInfo1.text = obj["info"] as? String
                            videoLink1.text = obj["link"] as? String

                            let urlYoutube = obj["link"] as? String
                            let urlID = urlYoutube?.youtubeID
                            let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
                            let url = URL(string: urlStr)!
                            videoLinkImg1.sd_setImage(with: url, completed: nil)
                            

                        }else if i == 1 {
                            videoLinkStackTOpContraint.constant = 16
                           videoLinkViewTwo.isHidden = false
                           videoLinkStackviewHeightConstraint.constant = 250
                            videoLinkTitle2.text = obj["title"] as? String
                            videoLinkInfo2.text = obj["info"] as? String
                            videoLink2.text = obj["link"] as? String
                            let urlYoutube = obj["link"] as? String
                            let urlID = urlYoutube?.youtubeID
                            let urlStr = "http://img.youtube.com/vi/\(urlID ?? "")/1.jpg"
                            let url = URL(string: urlStr)!
                            videoLinkImg2.sd_setImage(with: url, completed: nil)
                            
                        }
                    }
                    if videoLinkArr.count>2{
                        videoLinkbtnOutletSeeMore.isHidden = false
                    }
                    viewAlertAddLinks.isHidden = true

                    
                }
            }else{
                //external
                if txtPopupTitle.text == "" && txtviewPopopInfo.text == "" {
                    let alert1 = UIAlertController(title: "Alert!", message: "Please Enter all Details", preferredStyle: .alert)
                    let dismiss = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    alert1.addAction(dismiss)
                    present(alert1, animated: true, completion: nil)
                }
                else {

                    let dict:[String:Any] = ["link": "\(externalLinkTextField.text.unsafelyUnwrapped)",
                            "title": "\(txtPopupTitle.text.unsafelyUnwrapped)",
                            "info":"\(txtviewPopopInfo.text.unsafelyUnwrapped)"]
                    docLinkArr.append(dict)
                    print("Data Added")
                    print("The Count is :\(docLinkArr)")
                    
                    for i in 0..<docLinkArr.count {
                        let obj = docLinkArr[i]
                        if i == 0{
                            
                            print(obj)
                            rxternalLinkStackTOpContraint.constant = 16
                           externalLinkVIewOne.isHidden = false
                            externalLinkStackviewHeightConstraint.constant = 130
                            externalLinkTitle1.text = obj["title"] as? String
                            externalLinkInfo1.text = obj["info"] as? String
                            externalLink1.text = obj["link"] as? String
                        
                        }else if i == 1 {
                            print(obj)
                            rxternalLinkStackTOpContraint.constant = 16
                            externalLinkViewTwo.isHidden = false
                            externalLinkStackviewHeightConstraint.constant = 250
                            externalLinkTitle2.text = obj["title"] as? String
                            externalLinkInfo2.text = obj["info"] as? String
                            externalLink2.text = obj["link"] as? String
                        }
                    }
                    if docLinkArr.count>2{
                        externalbtnOutletSeeMore.isHidden = false
                    }
                    viewAlertAddLinks.isHidden = true

                }
                
                
            viewAlertAddLinks.isHidden = true

                
            }

        }
    }

	
    
}

//MARK:- Remove object From Array
extension CategoryCommonViewController{
    @objc func removeCoverImage(sender: UIButton)
    {
        self.coverImageArr.remove(at: sender.tag)
        self.arrCoverimage.remove(at: sender.tag)
        self.setupCollectionView()
    }
    @objc func removeImages(sender: UIButton)
    {
        self.mutipleImageArr.remove(at: sender.tag)
        self.arrimages.remove(at: sender.tag)
        self.SelectedAssests.remove(at: sender.tag)
        self.setupCollectionView1()
    }
    @objc func removeVideos(sender: UIButton)
    {
        self.thumbNailImageArr.remove(at: sender.tag)
        self.videoArr.remove(at: sender.tag)
        self.setupCollectionView5()
    }

    @objc func removeDocuments(sender: UIButton)
    {
        self.DocumentArray.remove(at: sender.tag)
        self.arrDoc.remove(at: sender.tag)
        self.setupCollectionView2()
    }
}
//MARK:- DatePicker Action
extension CategoryCommonViewController{
    
       @objc func startDatetapDone() {
           if let datePicker = self.startDateTextField.inputView as? UIDatePicker {
            if #available(iOS 13.4, *) {
                      datePicker.preferredDatePickerStyle = .wheels
                  } else {
                      // Fallback on earlier versions
                  }
               let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
               self.startDateTextField.text = dateformatter.string(from: datePicker.date) //2-4
           }
           self.startDateTextField.resignFirstResponder() // 2-5
       }
    @objc func endDatetapDone() {
        if let datePicker = self.endDateTextField.inputView as? UIDatePicker {
         if #available(iOS 13.4, *) {
                   datePicker.preferredDatePickerStyle = .wheels
               } else {
                   // Fallback on earlier versions
               }
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
            self.endDateTextField.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.endDateTextField.resignFirstResponder() // 2-5
    }
}



extension CategoryCommonViewController{
    func createKaizen(){
        
        
        if titleInputTextField.text == "" && descriptionTextView.text == "" && chooseTypeTextField.text == "" && startDateTextField.text == "" {
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter All Feilds", controller: self)
            
        }else if titleInputTextField.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Title", controller: self)
            
        }else if descriptionTextView.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter Description", controller: self)
            
        }else if chooseTypeTextField.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Select the type", controller: self)
            
        }else if startDateTextField.text == ""{
            GlobalObj.showAlertVC(title: "Oops", message: "Please Enter the Start Date", controller: self)
            
        }else{
            viewModel.callWebserviceForAdddEvent()
        }
    }
}


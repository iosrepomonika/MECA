
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
        
        self.photoCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        // Do any additional setup after loading the view.
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        self.imageandVideoCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        // Do any additional setup after loading the view.
        imageandVideoCollectionView.dataSource = self
        imageandVideoCollectionView.delegate = self
        
        self.documentCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        // Do any additional setup after loading the view.
        documentCollectionView.dataSource = self
        documentCollectionView.delegate = self
        
        self.videoCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        // Do any additional setup after loading the view.
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
        
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
    
    //2
       @objc func startDatetapDone() {
           if let datePicker = self.startDateTextField.inputView as? UIDatePicker {
            // 2-1
            if #available(iOS 13.4, *) {
                      datePicker.preferredDatePickerStyle = .wheels
                  } else {
                      // Fallback on earlier versions
                  }
               let dateformatter = DateFormatter() // 2-2
            dateformatter.dateFormat = "yyyy-MM-dd"// 2-3
               self.startDateTextField.text = dateformatter.string(from: datePicker.date) //2-4
           }
           self.startDateTextField.resignFirstResponder() // 2-5
       }
    @objc func endDatetapDone() {
        if let datePicker = self.endDateTextField.inputView as? UIDatePicker {
         // 2-1
         if #available(iOS 13.4, *) {
                   datePicker.preferredDatePickerStyle = .wheels
               } else {
                   // Fallback on earlier versions
               }
            let dateformatter = DateFormatter()
            // 2-2
            dateformatter.dateFormat = "yyyy-MM-dd"
         //   dateformatter.dateStyle = .none // 2-3
            self.endDateTextField.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.endDateTextField.resignFirstResponder() // 2-5
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
            imageandVideoCollectionView.reloadData()
            print("No multiple iamges")
            
        }
        else {
            heightConstarint2.constant = 70
            imageandVideoCollectionView.reloadData()
            print(" having multiple iamges")
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
                imageandVideoCollectionView.reloadData()
                
            }
            
        }
        
        print("complete photo array \(self.mutipleImageArr)")
        setupCollectionView()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.reloadData()
        
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
        }else{
           //video link
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
                                             "Title": "\(txtPopupTitle.text.unsafelyUnwrapped)",
                                             "Info":"\(txtviewPopopInfo.text.unsafelyUnwrapped)"]
                    videoLinkArr.append(dict)
                    print("Data Added \(videoLinkArr)")
                    for i in 0..<videoLinkArr.count {
                        let obj = videoLinkArr[i]
                        if i == 0{
                            videoLinkStackTOpContraint.constant = 16
                           videoLinkVIewOne.isHidden = false
                           videoLinkStackviewHeightConstraint.constant = 130
                            videoLinkTitle1.text = obj["Title"] as? String
                            videoLinkInfo1.text = obj["Info"] as? String
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
                            videoLinkTitle2.text = obj["Title"] as? String
                            videoLinkInfo2.text = obj["Info"] as? String
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
                            "Title": "\(txtPopupTitle.text.unsafelyUnwrapped)",
                            "Info":"\(txtviewPopopInfo.text.unsafelyUnwrapped)"]
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
                            externalLinkTitle1.text = obj["Title"] as? String
                            externalLinkInfo1.text = obj["Info"] as? String
                            externalLink1.text = obj["link"] as? String
                        
                        }else if i == 1 {
                            print(obj)
                            rxternalLinkStackTOpContraint.constant = 16
                            externalLinkViewTwo.isHidden = false
                            externalLinkStackviewHeightConstraint.constant = 250
                            externalLinkTitle2.text = obj["Title"] as? String
                            externalLinkInfo2.text = obj["Info"] as? String
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

extension CategoryCommonViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == photoCollectionView) {
            return coverImageArr.count
        }
        else if (collectionView == imageandVideoCollectionView) {
            return mutipleImageArr.count
        }
        else if (collectionView == documentCollectionView) {
            return DocumentArray.count
        }
        else if (collectionView == videoCollectionView) {
            return thumbNailImageArr.count
        }
        
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == photoCollectionView) {
            let cell  = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
            cell.myImage.image = coverImageArr[indexPath.row]
            cell.playBtnRef.isHidden = true
            return cell
        }
        else if (collectionView == imageandVideoCollectionView) {
            
            let cell  = imageandVideoCollectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
            if imageValue == "0" {
                cell.myImage.image = mutipleImageArr[indexPath.row]
                cell.playBtnRef.isHidden = true
            }
            
            return cell
        }
        else if (collectionView == videoCollectionView) {
            
            let cell  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
            
            cell.myImage.image = thumbNailImageArr[indexPath.row]
            
            cell.playBtnRef.isHidden = false
            
            
            return cell
        }
        else if (collectionView == documentCollectionView) {
            let cell  = documentCollectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
            cell.myImage.image = DocumentArray[indexPath.row]
            
            cell.playBtnRef.isHidden = true

            return cell
        }
        return UICollectionViewCell()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 70, height: 70)
        
    }
    
}
extension CategoryCommonViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    
    func presentPhotoActionSheet() {
        
        let alert = UIAlertController(title: "Add Cover Image", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        let cameraAlert = UIAlertAction(title: "Camera",
                                        style: .default,
                                        handler:{ [weak self] _ in
                                            self?.presentCamera()
                                           
                                            
                                            
                                        })
        let galleryAlert = UIAlertAction(title: "Gallery",
                                         style: .default,
                                         handler:{ [weak self] _ in
                                            
                                            self?.presentPhotoPicker()
                                         })
        let dismiss = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        alert.addAction(cameraAlert)
        alert.addAction(galleryAlert)
        self.present(alert, animated: true)
        alert.view.superview?.isUserInteractionEnabled = true
        alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        
    }
    @objc func dismissOnTapOutside(){
        self.dismiss(animated: true, completion: nil)
    }
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Images and videos
    func pickImageandVideo()
    {
        let alert =  UIAlertController(title: "Add Images or Videos", message: "What yoyu Would like to" , preferredStyle: .alert)
        
        
        let images = UIAlertAction(title: "Images", style: .default,handler:{ [weak self] _ in
            self?.presentPhotoPicker1()
            self?.imageAndVideoValue = "0"
            self?.imageValue = "0"
            
        })
        let videos = UIAlertAction(title: "Videos", style: .default,handler:{ [weak self] _ in
            
            self?.imageAndVideoValue = "1"
            self?.imageValue = "1"
            self?.pickVideos()
            
        })
        let dismiss = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        alert.addAction(images)
        alert.addAction(videos)
        self.present(alert, animated: true)
        alert.view.superview?.isUserInteractionEnabled = true
        alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        
    }
    
    func presentPhoto() {
        let actionSheet = UIAlertController(title: "Add Image",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                
                                                self?.presentCamera1()
                                                
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                
                                                self?.presentPhotoPicker1()
                                                
                                            }))
        let dismiss = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(dismiss)
        self.present(actionSheet, animated: true)
        actionSheet.view.superview?.isUserInteractionEnabled = true
        actionSheet.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
    }
    
    func presentCamera1() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker1() {
        
        let imagePicker = ImagePickerController()
        
        presentImagePicker(imagePicker, select: { (asset:PHAsset)  -> Void in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
            
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            for i in 0..<assets.count
            {
                self.SelectedAssests.append(assets[i])
                
            }
            
            self.convertAssetToImages()
            // User finished selection assets.
        })
    }
    func pickVideos() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) ?? []
        picker.mediaTypes = ["public.movie"]
        picker.videoQuality = .typeMedium
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if imageAndVideoValue == "1" {
            dismiss(animated: true, completion: nil)
            guard let movieUrl = info[.mediaURL] as? URL else { return }
            print(movieUrl)
            videoArr.append(movieUrl)
            ///
            
                do {
                    let videoData = try Data(contentsOf: movieUrl as URL)
                    arrvideos.append(videoData)
                } catch {
                    print("Unable to load data: \(error)")
                }
            
            
            AVAsset(url: movieUrl).generateThumbnail { [weak self] (image) in
                DispatchQueue.main.async { [self] in
                    guard let image = image else { return }
                    print(image)
                    
                    self?.thumbNailImageArr.append(image)
                    self?.videoCollectionView.reloadData()
                    self?.setupCollectionView5()
                    
                }
            }
        }else {
            var selectedImageFromPicker: UIImage?
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                selectedImageFromPicker = editedImage
            } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImageFromPicker = originalImage
            }
            
            if let selectedImage = selectedImageFromPicker {
                coverImageArr.append(selectedImage)
                arrCoverimage.append(selectedImage.jpegData(compressionQuality: 0.5)!)
                
            }
            
            dismiss(animated: true, completion: nil)
            setupCollectionView()
            self.photoCollectionView.reloadData()
            
        }
        
        
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
            callWebserviceForAdddEvent()
            //viewModel.webServiceForCreateKaizen(param: param)
        }
    }
}
//MARK:- Webservice
extension CategoryCommonViewController{
    
    func callWebserviceForAdddEvent()
    
    {
    var strType = ""
        if chooseTypeTextField.text == "New Car Sales"{
            strType = "1"
        }else if chooseTypeTextField.text == "After Sales"{
            strType = "2"
        }else if chooseTypeTextField.text == "Trade In"{
            strType = "3"
        }else if chooseTypeTextField.text == "BIT Foundation"{
            strType = "4"
        }
        
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        GlobalObj.displayLoader(true, show: true)

        let url = BaseURL + add_event
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)

        headers = ["Authorization":"Bearer \(accessToken ?? "")"	]

        
        
//        var  dict = [String:Any]()
//        var docDict = [String:Any]()
//
//        dict = ["link":"https://www.youtube.com/watch?v=6zgm0cN8CQg",
//                "title":"video1","info":"video1 info"]
//        videoLinkArr.append(dict)
//
//        dict = ["link":"https://www.youtube.com/watch?v=6zgm0cN8CQg",
//                "title":"video2","info":"video2 info"]
//        videoLinkArr.append(dict)
//        print(videoLinkArr)
//        docDict = ["link":"https://drive.google.com/file/d/1k07NiURpG7SE2EFXSEm3sGe9_kGxuI6D/view",
//                "title":"link1","info":"Doc1 info"]
//        docLinkArr.append(docDict)
        print(videoLinkArr)
        print(docLinkArr)
        let parameters: [String: Any] = [
            "video_links" : videoLinkArr,
            "document_links" : docLinkArr,
        ]
       
        AF.upload(multipartFormData: { (multipartFormData) in
           

            for (key, value) in parameters {
                
                if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
//                    multipartFormData.append(jsonData, withName: key as String)
                    let data = (String(data: jsonData, encoding: String.Encoding.utf8) ?? "") as String
                    let somedata = data.data(using: String.Encoding.utf8)
                    multipartFormData.append(somedata ?? Data(), withName: key as String)

                }
            }
                               
            multipartFormData.append(self.titleInputTextField.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"title")

            multipartFormData.append(self.descriptionTextView.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"description")
         
            multipartFormData.append(strType.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"type")
         
            multipartFormData.append(self.startDateTextField.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"start_date")
            
            multipartFormData.append(self.endDateTextField.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"end_date")

           
            for i in 0..<self.arrimages.count{
                let name = "event_images[\(i)]"
                let img = self.arrimages[i]
//                multipartFormData.append(img, withName: name , fileName: "\(timestamp).jpeg", mimeType: "image/jpeg")
                multipartFormData.append(img, withName: name , fileName: "file.jpeg", mimeType: "image/jpeg")

            }
            //event_documents
          
            for i in 0..<self.arrvideos.count{
                let name = "event_videos[\(i)]"
                let img = self.arrvideos[i]
                let timestamp = NSDate().timeIntervalSince1970
                multipartFormData.append(img, withName: name , fileName: "\(timestamp).mp4", mimeType: "\(timestamp)/mp4")
                                
            }
            
            for img in self.arrCoverimage{
                
                multipartFormData.append(img, withName: "newcover" , fileName: "file.jpeg", mimeType: "image/jpeg")
                                
            }

        }, to: url, method: .post,headers:headers).responseJSON(completionHandler: { (response) in
            print(response.value as Any)
            GlobalObj.displayLoader(true, show: false)

            if let objData = response.value as? [String:Any]{
                let msg = objData["message"] as! String
            if msg == "Kaizen Added successfully"{
                self.navigationController?.popViewController(animated: true)
            }
            }else{
            print(response.error as Any)
                GlobalObj.displayLoader(true, show: false)

                self.showToast(message: response.error.debugDescription)
            }
        })
print("error")
    }
   

  
}
// MARK: UIPickerView Delegation

extension CategoryCommonViewController : UIPickerViewDelegate, UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typePickerData.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return typePickerData[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chooseTypeTextField.text = typePickerData[row]
    }
}
//MARK:- Document picker

extension CategoryCommonViewController : UIDocumentMenuDelegate,UIDocumentPickerDelegate{
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)

    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
     print("import result : \(myURL)")
        drawPDFfromURL(url: myURL) { (img) in
            if img != nil{
            self.DocumentArray.append(img!)
            }
            if self.DocumentArray.count>0{
                self.setupCollectionView2()
            }
        }
    }
          

//    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
//        documentPicker.delegate = self
//        present(documentPicker, animated: true, completion: nil)
//    }


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    func drawPDFfromURL(url: URL,completion: @escaping (UIImage?) -> Void) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        
        let pageRect = page.getBoxRect(.cropBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            //ctx.fill(pageRect)
            ctx.fill(CGRect.init(x: 0, y: 0, width: 70, height: 70))
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
            
        }
        completion(img)
        return img
    }
}
//Generating Thumbnail
import AVKit

extension AVAsset {
    
    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
}

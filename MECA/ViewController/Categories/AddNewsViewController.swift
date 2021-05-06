

import UIKit
import Photos
import BSImagePicker

class AddNewsViewController: UIViewController {
    
    
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var dismissVCRefBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dismissVC2RefBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabelRef: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryLabelRef: UILabel!
    @IBOutlet weak var categoryInputTextfield: UITextField!
    @IBOutlet weak var newsContentLabelRef: UILabel!
    @IBOutlet weak var newsContentView: UIView!
    @IBOutlet weak var newsContentTextView: UITextView!
    @IBOutlet weak var tagsLabelRef: UILabel!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var coverImageLabel: UILabel!
    @IBOutlet weak var onClickPhotoRefBtn: UIButton!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var documentsRefLabel: UILabel!
    @IBOutlet weak var addFileBtnRef: UIButton!
    @IBOutlet weak var addRefBtn: UIButton!
   
    @IBOutlet weak var photCollectionHeightContraint: NSLayoutConstraint!
    var myImageArr = [UIImage]()
    var SelectedAssests = [PHAsset]()
    var ImageArray = [UIImage]()
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var viewModel : AddNewsVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddNewsVM.init(controller: self)
        self.photoCollectionView.register(UINib(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCollectionViewCell")
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        setupUI()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionView()
    }
    
    func setupUI(){
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        categoryInputTextfield.layer.borderWidth = 1
        categoryInputTextfield.layer.borderColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        onClickPhotoRefBtn.layer.borderWidth = 1
        onClickPhotoRefBtn.layer.borderColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        addFileBtnRef.layer.borderWidth = 1
        addFileBtnRef.layer.borderColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        addRefBtn.layer.borderWidth = 1
        addRefBtn.layer.borderColor = #colorLiteral(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
        titleTextField.layer.cornerRadius = 8
        categoryInputTextfield.layer.cornerRadius = 8
        newsContentView.layer.cornerRadius = 8
        newsContentTextView.layer.cornerRadius = 8
        addRefBtn.layer.cornerRadius = 16
        addFileBtnRef.layer.cornerRadius = 8
        onClickPhotoRefBtn.layer.cornerRadius = 8
        tagView.layer.cornerRadius = 8
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                layout.itemSize = CGSize(width: screenWidth/2, height: 70)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
                 layout.scrollDirection = .horizontal
               photoCollectionView!.collectionViewLayout = layout
    
    }

    func setupCollectionView() {
        if ImageArray.isEmpty {
         
            photCollectionHeightContraint.constant = 0
            photoCollectionView.reloadData()
            print("No image Data")
        }
        else if !ImageArray.isEmpty {
            
            photCollectionHeightContraint.constant = 70
            photoCollectionView.reloadData()
            print("image Data is there")
        }
    }
  
}
//MARK: UIButton Action
extension AddNewsViewController{
    @IBAction func onClickDismissVC(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickDismissVC2(_ sender: UIButton) {
        let mainVC = FlowController().instantiateViewController(identifier: "HomeNav", storyBoard: "Home")
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = mainVC
        appDel.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func onClickAddPhoto(_ sender: UIButton) {
        self.presentPhotoPicker()
       
    }
    
    
    @IBAction func onClickAddFile(_ sender: UIButton) {
    }
    
    @IBAction func onClickAddData(_ sender: UIButton) {
    }
    
}
//MARK: UICollectionview Delegate
extension AddNewsViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.getItemForRowAt(indexPath, collectionView: photoCollectionView)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)

    }

}
extension AddNewsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Add Image",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in

                                                self?.presentCamera()

        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in

                    self?.presentPhotoPicker()

        }))

        self.present(actionSheet, animated: true)
    }

    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    func presentPhotoPicker() {
        
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
    
    func convertAssetToImages() -> Void {
        
        if SelectedAssests.count != 0{
            
            if ImageArray.count > 0 {
                ImageArray.removeAll()

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
                let newImage = UIImage(data: data!)
              
                
                self.ImageArray.append(newImage! as UIImage)
                
            }

        }
        
        print("complete photo array \(self.ImageArray)")
        setupCollectionView()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.reloadData()

    }
    }

   





import Foundation
import UIKit
import Alamofire
import AVKit
import Photos
import BSImagePicker
import MobileCoreServices
import AVFoundation


class CreateKaizenVM: BaseCollectionViewVM {
    
    
    override init(controller: UIViewController?) {
        
        super.init(controller: controller)
      actualController = controller

    }

    
}

extension CreateKaizenVM{
    
    func callWebserviceForAdddEvent(){
    var strType = ""
        if (actualController as! CategoryCommonViewController).chooseTypeTextField.text == "New Car Sales"{
            strType = "1"
        }else if (actualController as! CategoryCommonViewController).chooseTypeTextField.text == "After Sales"{
            strType = "2"
        }else if (actualController as! CategoryCommonViewController).chooseTypeTextField.text == "Trade In"{
            strType = "3"
        }else if (actualController as! CategoryCommonViewController).chooseTypeTextField.text == "BIT Foundation"{
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

        headers = ["Authorization":"Bearer \(accessToken ?? "")"    ]

        let parameters: [String: Any] = [
            "video_links" : (actualController as! CategoryCommonViewController).videoLinkArr,
            "document_links" : (actualController as! CategoryCommonViewController).docLinkArr,
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
                               
            multipartFormData.append((self.actualController as! CategoryCommonViewController).titleInputTextField.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"title")

            multipartFormData.append((self.actualController as! CategoryCommonViewController).descriptionTextView.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"description")
         
            multipartFormData.append(strType.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"type")
         
            multipartFormData.append((self.actualController as! CategoryCommonViewController).startDateTextField.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"start_date")
            
            multipartFormData.append((self.actualController as! CategoryCommonViewController).endDateTextField.text!.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data(), withName :"end_date")

           
            for i in 0..<(self.actualController as! CategoryCommonViewController).arrimages.count{
                let name = "event_images[\(i)]"
                let img = (self.actualController as! CategoryCommonViewController).arrimages[i]
                multipartFormData.append(img, withName: name , fileName: "file.jpeg", mimeType: "image/jpeg")

            }
            
      


            for i in 0..<(self.actualController as! CategoryCommonViewController).arrvideos.count{
                let name = "event_videos[\(i)]"
                let img = (self.actualController as! CategoryCommonViewController).arrvideos[i]
                let timestamp = NSDate().timeIntervalSince1970
                multipartFormData.append(img, withName: name , fileName: "\(timestamp).mp4", mimeType: "\(timestamp)/mp4")
                                
            }
            
            for img in (self.actualController as! CategoryCommonViewController).arrCoverimage{
                
                multipartFormData.append(img, withName: "newcover" , fileName: "file.jpeg", mimeType: "image/jpeg")
                                
            }

        }, to: url, method: .post,headers:headers).responseJSON(completionHandler: { (response) in
            print(response.value as Any)
            GlobalObj.displayLoader(true, show: false)

            if let objData = response.value as? [String:Any]{
                let msg = objData["message"] as! String
            if msg == "Kaizen Added successfully"{
                (self.actualController as! CategoryCommonViewController).navigationController?.popViewController(animated: true)
            }
            }else{
            print(response.error as Any)
                GlobalObj.displayLoader(true, show: false)

                (self.actualController as! CategoryCommonViewController).showToast(message: response.error.debugDescription)
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
        do {
            let docData = try Data(contentsOf: myURL as URL)
            arrDoc.append(docData)
        } catch {
            print("Unable to load data: \(error)")
        }
        
        drawPDFfromURL(url: myURL) { (img) in
            if img != nil{
            self.DocumentArray.append(img!)
            }
            if self.DocumentArray.count>0{
                self.setupCollectionView2()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                self.documentCollectionView.reloadData()
            }
        }
    }
          


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
            self.dismiss(animated: true, completion: nil)
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

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                        self?.videoCollectionView.reloadData()
                    }
                    
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
            DispatchQueue.main.async {
                self.photoCollectionView.reloadData()
            }
        }
        
    }
    
}

//MARK:- Collectionview Delegate
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
            cell.removeButton.tag = indexPath.row
            cell.removeButton.removeTarget(self, action: #selector(self.removeCoverImage), for: .touchUpInside)
            cell.removeButton.addTarget(self, action: #selector(self.removeCoverImage), for: .touchUpInside)
            return cell
        }
        else if (collectionView == imageandVideoCollectionView) {
            
            let cell  = imageandVideoCollectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
            cell.removeButton.tag = indexPath.row
            cell.removeButton.removeTarget(self, action: #selector(self.removeImages), for: .touchUpInside)
            cell.removeButton.addTarget(self, action: #selector(self.removeImages), for: .touchUpInside)
            if imageValue == "0" {
                cell.removeButton.isHidden = false
                cell.myImage.image = mutipleImageArr[indexPath.row]
                cell.playBtnRef.isHidden = true
            }
            else
            {
                cell.removeButton.isHidden = true
            }
            
            return cell
        }
        else if (collectionView == videoCollectionView) {
            
            let cell  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
            cell.removeButton.tag = indexPath.row
            cell.removeButton.removeTarget(self, action: #selector(self.removeVideos), for: .touchUpInside)
            cell.removeButton.addTarget(self, action: #selector(self.removeVideos), for: .touchUpInside)
            cell.myImage.image = thumbNailImageArr[indexPath.row]
            
            cell.playBtnRef.isHidden = false
            
            
            return cell
        }
        else if (collectionView == documentCollectionView) {
            let cell  = documentCollectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
            cell.removeButton.tag = indexPath.row
            cell.removeButton.removeTarget(self, action: #selector(self.removeDocuments), for: .touchUpInside)
            cell.removeButton.addTarget(self, action: #selector(self.removeDocuments), for: .touchUpInside)
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

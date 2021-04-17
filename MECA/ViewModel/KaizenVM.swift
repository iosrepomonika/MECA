


import Foundation
import UIKit
import SDWebImage
import AVFoundation

class KaizenVM: NSObject {
    var actualController:UIViewController?
    var arrKaizenInfo:[KaizenInfoDataModel] = []
    var strdescription = ""
    var arrEventImg = [Event_videos]()
    var arrEventVideos = [Event_videos]()


    init(controller:UIViewController?) {
        self.actualController = controller
        
        (actualController as! DetailViewController).viewVideoCollection.isHidden = true
        (actualController as! DetailViewController).viewViideoHeightConstraint.constant = 0
        (actualController as! DetailViewController).viewVideoTopCOnstrint.constant = 0
        
        (actualController as! DetailViewController).viewImagCollection.isHidden = true
        (actualController as! DetailViewController).viewImgCollectHeightConstraint.constant = 0
        (actualController as! DetailViewController).viewImgTopConstrint.constant = 0
      
        (actualController as! DetailViewController).viewSurvayLinkHeightConstraint.constant = 0
        (actualController as! DetailViewController).surveyLinkRefBtn.isHidden = true
        (actualController as! DetailViewController).surveyLinkLabel.isHidden = true
        (actualController as! DetailViewController).viewLinkTopContraint.constant = 0
        
        (actualController as! DetailViewController).locationviewHeightConstraint.constant = 0
        (actualController as! DetailViewController).locationView.isHidden = true
        
        
        (actualController as! DetailViewController).viewEventContent.isHidden = true
        (actualController as! DetailViewController).viewEventContentHeightConstraint.constant = 0
        (actualController as! DetailViewController).viewEventTopConstraint.constant = 0
        
    }
   
    func callKaizenInfoWebservice(completion:@escaping(Bool) -> Void) {
        GlobalObj.displayLoader(true, show: true)
        print((actualController as! DetailViewController).eventID)
		APIClient.webserviceForKaizenInfo(eventId: (actualController as! DetailViewController).eventID) { (result) in
            
            if let respCode = result.resp_code{
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let objDate = result.data {
            
                        let imgURL = BaseURL + objDate.cover_image!
                        
                        (self.actualController as! DetailViewController).mainImageView.sd_setImage(with: URL(string:imgURL), completed: nil)
                        (self.actualController as! DetailViewController).toyota2021TitleLabel.text = objDate.title
                        self.strdescription = objDate.description ?? ""
                        (self.actualController as! DetailViewController).eventSubTitleLabel.text = objDate.description

                        (self.actualController as! DetailViewController).aboutEventLabel.text = "About Event"
                        let likes = String(objDate.likes ?? 0) + " Likes"
                        (self.actualController as! DetailViewController).likeLabel.text = likes

                        if objDate.start_date != ""{
                            
                            let startDate = NSString.convertFormatOfDate(date: objDate.start_date ?? "", originalFormat: "yyyy-mm-dd", destinationFormat: "dd MMMM yyyy")
                            (self.actualController as! DetailViewController).eventStartDateLabel.text = startDate
                            
                            
                            if let weekday = self.getDayOfWeek(startDate!) {
                                print(weekday)
                                switch weekday {
                                case 1:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Sunday"
                                case 2:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Monday"
                                case 3:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Tuesday"
                                case 4:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Wednesday"
                                    
                                case 5:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Thursday"
                                case 6:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Friday"
                                case 7:
                                    (self.actualController as! DetailViewController).eventStartDayLabel.text = "Saturday"
                                default:
                                    print("Error fetching days")
                                ///  return "Day"
                                }
                            } else {
                                print("bad input")
                            }
                        }
                        if objDate.end_date != ""{
                            let endDate = NSString.convertFormatOfDate(date: objDate.end_date ?? "", originalFormat: "yyyy-mm-dd", destinationFormat: "dd MMMM yyyy")
                            (self.actualController as! DetailViewController).eventEndDateLabel.text = endDate
                            
                            if let weekday = self.getDayOfWeek(endDate!) {
                                print(weekday)
                                switch weekday {
                                case 1:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Sunday"
                                case 2:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Monday"
                                case 3:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Tuesday"
                                case 4:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Wednesday"
                                    
                                case 5:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Thursday"
                                case 6:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Friday"
                                case 7:
                                    (self.actualController as! DetailViewController).eventEndDaylabel.text = "Saturday"
                                default:
                                    print("Error fetching days")
                                ///  return "Day"
                                }
                            } else {
                                print("bad input")
                            }
                        }
                        
                        if objDate.event_videos?.count == 0{
                            (self.actualController as! DetailViewController).viewVideoCollection.isHidden = true
                            (self.actualController as! DetailViewController).viewViideoHeightConstraint.constant = 0
                            (self.actualController as! DetailViewController).viewVideoTopCOnstrint.constant = 0

                        }else{
                            (self.actualController as! DetailViewController).viewVideoCollection.isHidden = false
                            (self.actualController as! DetailViewController).viewViideoHeightConstraint.constant = 159
                            (self.actualController as! DetailViewController).viewVideoTopCOnstrint.constant = 20
                            self.arrEventVideos = objDate.event_videos!
                            (self.actualController as! DetailViewController).videoCollectionView.delegate = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).videoCollectionView.dataSource = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).videoCollectionView.reloadData()


                        }
                        if objDate.event_images?.count == 0{
                            (self.actualController as! DetailViewController).viewImagCollection.isHidden = true
                            (self.actualController as! DetailViewController).viewImgCollectHeightConstraint.constant = 0
                            (self.actualController as! DetailViewController).viewImgTopConstrint.constant = 0
                        }else{

                            (self.actualController as! DetailViewController).viewImagCollection.isHidden = false
                            (self.actualController as! DetailViewController).viewImgCollectHeightConstraint.constant = 159
                            (self.actualController as! DetailViewController).imageCollectionView.isHidden = false
                            (self.actualController as! DetailViewController).viewImgTopConstrint.constant = 20
                            self.arrEventImg = objDate.event_images!

                            (self.actualController as! DetailViewController).imageCollectionView.delegate = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).imageCollectionView.dataSource = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).imageCollectionView.reloadData()

                        }
                        
                        if objDate.video_links?.count == 0{
                            (self.actualController as! DetailViewController).viewVideoLink.isHidden = true
                            (self.actualController as! DetailViewController).viewVideoLinkTopConstraint.constant = 0
                            (self.actualController as! DetailViewController).viewVideoLinkHeightConstraint.constant = 0
                            
                        }else{
                            for i in 0..<objDate.video_links!.count {
                                let obj = objDate.video_links![i]
                                if i == 0 {
                                    (self.actualController as! DetailViewController).viewVideoLink.isHidden = false
                                    (self.actualController as! DetailViewController).viewVideoLinkTopConstraint.constant = 20
                                    (self.actualController as! DetailViewController).viewVideoLinkHeightConstraint.constant = 80
                                    (self.actualController as! DetailViewController).videoLinkRefBtn1.setTitle(obj.link, for: .normal)
                                    (self.actualController as! DetailViewController).videoLinkSeeMoreBtn.isHidden = true

                                }else if i == 1 {
                                    (self.actualController as! DetailViewController).viewDocumentLink.isHidden = false
                                    (self.actualController as! DetailViewController).viewDocumentLinkTOpConstrainrt.constant = 20
                                    (self.actualController as! DetailViewController).viewDocumentLinkHeightConstraint.constant = 110
                                    (self.actualController as! DetailViewController).videoLinkRefBtn2.setTitle(obj.link, for: .normal)
                                    (self.actualController as! DetailViewController).videoLinkSeeMoreBtn.isHidden = true

                                }
                                

                            }
//                            (self.actualController as! DetailViewController).viewVideoLink.isHidden = false
//                            (self.actualController as! DetailViewController).viewVideoLinkTopConstraint.constant = 20
//                            (self.actualController as! DetailViewController).viewVideoLinkHeightConstraint.constant = 110
                            if objDate.video_links!.count>2{
                                (self.actualController as! DetailViewController).videoLinkSeeMoreBtn.isHidden = false

                            }
                            
                        }
                       
                        if objDate.document_links?.count == 0{
                            (self.actualController as! DetailViewController).viewDocumentLink.isHidden = true
                            (self.actualController as! DetailViewController).viewDocumentLinkTOpConstrainrt.constant = 0
                            (self.actualController as! DetailViewController).viewDocumentLinkHeightConstraint.constant = 0
                            (self.actualController as! DetailViewController).documentLinkSeeMoreBtn1.isHidden = true

                        }else{
                            for i in 0..<objDate.document_links!.count {
                                let obj = objDate.document_links![i]
                                if i == 0 {
                                    (self.actualController as! DetailViewController).viewDocumentLink.isHidden = false
                                    (self.actualController as! DetailViewController).viewDocumentLinkTOpConstrainrt.constant = 20
                                    (self.actualController as! DetailViewController).viewDocumentLinkHeightConstraint.constant = 80
                                    (self.actualController as! DetailViewController).documentLinkRefBtn1.setTitle(obj.link, for: .normal)
                                    (self.actualController as! DetailViewController).documentLinkSeeMoreBtn1.isHidden = true

                                }else if i == 1 {
                                    (self.actualController as! DetailViewController).viewDocumentLink.isHidden = false
                                    (self.actualController as! DetailViewController).viewDocumentLinkTOpConstrainrt.constant = 20
                                    (self.actualController as! DetailViewController).viewDocumentLinkHeightConstraint.constant = 110
                                    (self.actualController as! DetailViewController).documentLinkRefBtn2.setTitle(obj.link, for: .normal)
                                    (self.actualController as! DetailViewController).documentLinkSeeMoreBtn1.isHidden = true

                                }
                                

                            }
                            if objDate.document_links!.count>2{
                                (self.actualController as! DetailViewController).videoLinkSeeMoreBtn.isHidden = false
                            }
                           
                            
                        }

                        completion(true)
                    }
                }

            }
        }
    }
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
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




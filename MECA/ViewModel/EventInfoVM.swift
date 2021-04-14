

import Foundation
import UIKit
import SDWebImage

class EventInfoVM: NSObject {
    var actualController:UIViewController?

    var strdescription = ""
    var arrEventImg = [Event_videos]()
    var arrEventVideos = [Event_videos]()
    
    init(controller:UIViewController?) {
        self.actualController = controller
        
        (actualController as! DetailViewController).locationviewHeightConstraint.constant = 0
        (actualController as! DetailViewController).locationView.isHidden = true
    }
   
    func callEventInfoWebservice() {
        GlobalObj.displayLoader(true, show: true)
		APIClient.webserviceForEventInfo(eventID: (actualController as! DetailViewController).eventID, isEvent: (actualController as! DetailViewController).isEvent) { [self] (result) in

            if let respCode = result.resp_code{

                if respCode == 200{

                    if let objDate = result.data {
                        if objDate.cover_image != ""{
                            let imgURl = BaseURL + objDate.cover_image!
                            (actualController as! DetailViewController).mainImageView.sd_setImage(with: URL.init(string: imgURl), completed: nil)
                        }
                        
                        (actualController as! DetailViewController).toyota2021TitleLabel.text = objDate.title
                        (actualController as! DetailViewController).likeLabel.text = String((objDate.likes)!)
                        (actualController as! DetailViewController).eventSubTitleLabel.text = objDate.description
                       
                        if objDate.survey_link == ""{
                            (actualController as! DetailViewController).viewSurvayLinkHeightConstraint.constant = 0
                            (actualController as! DetailViewController).viewLinkTopContraint.constant = 0
                            (actualController as! DetailViewController).surveyLinkRefBtn.isHidden = true
                            (actualController as! DetailViewController).surveyLinkLabel.isHidden = true
                        }else{
                            (actualController as! DetailViewController).viewSurvayLinkHeightConstraint.constant = 63
                            (actualController as! DetailViewController).viewLinkTopContraint.constant = 23
                            (actualController as! DetailViewController).surveyLinkRefBtn.isHidden = false
                            (actualController as! DetailViewController).surveyLinkLabel.isHidden = false
                            (actualController as! DetailViewController).surveyLinkRefBtn.setTitle(objDate.survey_link, for: .normal)
                            
                        }
                        
                        strdescription = objDate.description ?? ""
                                                
                        (actualController as! DetailViewController).aboutEventLabel.text = "About Event"
                        if objDate.start_date != ""{
                            let startDate = NSString.convertFormatOfDate(date: objDate.start_date ?? "", originalFormat: "yyyy-mm-dd", destinationFormat: "dd MMMM yyyy")
                            (actualController as! DetailViewController).eventStartDateLabel.text = startDate
                            if let weekday = getDayOfWeek(startDate!) {
                                print(weekday)
                                switch weekday {
                                case 1:
                                    (actualController as! DetailViewController).eventStartDayLabel.text = "Sunday"
                                case 2:
                                    (actualController as! DetailViewController).eventStartDayLabel.text = "Monday"
                                case 3:
                                    (actualController as! DetailViewController).eventStartDayLabel.text = "Tuesday"
                                case 4:
                                    (actualController as! DetailViewController).eventStartDayLabel.text = "Wednesday"
                                    
                                case 5:
                                    (actualController as! DetailViewController).eventStartDayLabel.text = "Thursday"
                                case 6:
                                    (actualController as! DetailViewController).eventStartDayLabel.text = "Friday"
                                case 7:
                                    (actualController as! DetailViewController).eventStartDayLabel.text = "Saturday"
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
                            (actualController as! DetailViewController).eventEndDateLabel.text = endDate
                            
                            if let weekday = getDayOfWeek(endDate!) {
                                print(weekday)
                                switch weekday {
                                case 1:
                                    (actualController as! DetailViewController).eventEndDaylabel.text = "Sunday"
                                case 2:
                                    (actualController as! DetailViewController).eventEndDaylabel.text = "Monday"
                                case 3:
                                    (actualController as! DetailViewController).eventEndDaylabel.text = "Tuesday"
                                case 4:
                                    (actualController as! DetailViewController).eventEndDaylabel.text = "Wednesday"
                                    
                                case 5:
                                    (actualController as! DetailViewController).eventEndDaylabel.text = "Thursday"
                                case 6:
                                    (actualController as! DetailViewController).eventEndDaylabel.text = "Friday"
                                case 7:
                                    (actualController as! DetailViewController).eventEndDaylabel.text = "Saturday"
                                default:
                                    print("Error fetching days")
                                ///  return "Day"
                                }
                            } else {
                                print("bad input")
                            }
                        }
                        let formatter = DateFormatter()

                        if objDate.start_time != "" {
                        let startTime = objDate.start_time
                        formatter.locale = Locale(identifier: "en_US_POSIX")
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        if let date = formatter.date(from: startTime ?? "") {
                            formatter.dateFormat = "hh:mm a"
                            let timeStr = formatter.string(from: date)
                            (actualController as! DetailViewController).eventStartTimeLabel.text = timeStr
                            (actualController as! DetailViewController).eventStartTime2Label.text = timeStr
                        }
                        }
                        if objDate.end_time != "" {
                            
                            
                            let endTime = objDate.end_time
                            formatter.locale = Locale(identifier: "en_US_POSIX")
                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            if let date = formatter.date(from: endTime ?? "") {
                                formatter.dateFormat = "hh:mm a"
                                let timeStr = formatter.string(from: date)
                                (actualController as! DetailViewController).eventEndTimeLabel.text = timeStr
                                (actualController as! DetailViewController).eventEndTime2Label.text = timeStr
                            }
                            
                        }
                        if objDate.event_images?.count == 0{
                            (actualController as! DetailViewController).viewImagCollection.isHidden = true
                            (actualController as! DetailViewController).viewImgCollectHeightConstraint.constant = 0
                            (actualController as! DetailViewController).viewImgTopConstrint.constant = 0
                        }else{

                            (actualController as! DetailViewController).viewImagCollection.isHidden = false
                            (actualController as! DetailViewController).viewImgCollectHeightConstraint.constant = 159
                            (actualController as! DetailViewController).viewImgTopConstrint.constant = 20
                            arrEventImg = objDate.event_images!
                            (self.actualController as! DetailViewController).imageCollectionView.delegate = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).imageCollectionView.dataSource = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).imageCollectionView.reloadData()
                        }
                       
                        
                        if objDate.event_videos?.count == 0{
                            (actualController as! DetailViewController).viewVideoCollection.isHidden = true
                            (actualController as! DetailViewController).viewViideoHeightConstraint.constant = 0
                            (actualController as! DetailViewController).viewVideoTopCOnstrint.constant = 0

                        }else{
                            (actualController as! DetailViewController).viewVideoCollection.isHidden = false
                            (actualController as! DetailViewController).viewViideoHeightConstraint.constant = 159
                            (actualController as! DetailViewController).viewVideoTopCOnstrint.constant = 20
                            arrEventVideos = objDate.event_videos!
                            (self.actualController as! DetailViewController).videoCollectionView.delegate = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).videoCollectionView.dataSource = (self.actualController as! DetailViewController).self
                            (self.actualController as! DetailViewController).videoCollectionView.reloadData()

                        }
                        
                        GlobalObj.displayLoader(true, show: false)

                    }else{
                        GlobalObj.displayLoader(true, show: false)
                    }
                }else{
                    GlobalObj.displayLoader(true, show: false)
                }
            }

            GlobalObj.displayLoader(true, show: false)

        }
    }
  
    /*
     
     */
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
}

extension NSString {

class func convertFormatOfDate(date: String, originalFormat: String, destinationFormat: String) -> String! {

    // Orginal format :
    let dateOriginalFormat = DateFormatter()
    dateOriginalFormat.dateFormat = originalFormat      // in the example it'll take "yy MM dd" (from our call)

    // Destination format :
    let dateDestinationFormat = DateFormatter()
    dateDestinationFormat.dateFormat = destinationFormat // in the example it'll take "EEEE dd MMMM yyyy" (from our call)

    // Convert current String Date to NSDate
    let dateFromString = dateOriginalFormat.date(from: date)

    // Convert new NSDate created above to String with the good format
    let dateFormated = dateDestinationFormat.string(from: dateFromString!)

    return dateFormated

}
}

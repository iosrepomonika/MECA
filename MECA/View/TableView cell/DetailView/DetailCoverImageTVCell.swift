//
//  DetailCoverImageTVCell.swift
//  MECA
//
//  Created by Apoorva Gangrade on 20/04/21.
//

import UIKit
import SDWebImage

class DetailCoverImageTVCell: UITableViewCell {
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var btnBackOutlet: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblStartDay: UILabel!
    @IBOutlet weak var lblStartFromTime: UILabel!
    @IBOutlet weak var lblStartToTime: UILabel!
    @IBOutlet weak var lblEndFromTime: UILabel!
    @IBOutlet weak var lblEndToTime: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblEndDay: UILabel!
    @IBOutlet weak var viewStartDateHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewEndDateHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgTimeEndDate: UIImageView!
    @IBOutlet weak var imgTimeStartdate: UIImageView!
    @IBOutlet weak var imgDateStartDate: UIImageView!
    @IBOutlet weak var imgDateEndDate: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if  GlobalValue.tabCategory == "Maas" || GlobalValue.tabCategory == "Hydrogen" || GlobalValue.tabCategory == "SDGS"{
            viewStartDateHeightConstraint.constant = 50
            viewEndDateHeightConstraint.constant = 50
            imgTimeEndDate.isHidden = true
            imgTimeStartdate.isHidden = true
            lblStartFromTime.isHidden = true
            lblStartToTime.isHidden = true
            lblEndFromTime.isHidden = true
            lblEndToTime.isHidden = true
            imgDateEndDate.image = #imageLiteral(resourceName: "Start_Date")
            imgDateStartDate.image = #imageLiteral(resourceName: "Start_Date")

            //Start_Date
           
        }else{
            viewStartDateHeightConstraint.constant = 100
            viewEndDateHeightConstraint.constant = 100
            imgTimeEndDate.isHidden = false
            imgTimeStartdate.isHidden = false
            lblStartFromTime.isHidden = false
            lblStartToTime.isHidden = false
            lblEndToTime.isHidden = false
            lblEndFromTime.isHidden = false
            imgDateEndDate.image = #imageLiteral(resourceName: "date")
            imgDateStartDate.image = #imageLiteral(resourceName: "date")
        }
    }
    static func nib() -> UINib {
        return UINib(nibName: "DetailCoverImageTVCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setEventData(dataEvent:Data_Event) {
        lblTitle.text = dataEvent.title
        let imgURL = BaseURL + dataEvent.cover_image!
        imgCover.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgCover.sd_setImage(with: URL(string:imgURL), completed: nil)
        
        if dataEvent.start_date != ""{
            
            let startDate = NSString.convertFormatOfDate(date: dataEvent.start_date ?? "", originalFormat: "yyyy-mm-dd", destinationFormat: "dd MMMM yyyy")
            lblStartDate.text = startDate
            
            
            if let weekday = UtilesSwift.shared.getDayOfWeek(startDate!) {
                print(weekday)
                switch weekday {
                case 1:
                  lblStartDay.text = "Sunday"
                case 2:
                    lblStartDay.text = "Monday"
                case 3:
                    lblStartDay.text = "Tuesday"
                case 4:
                    lblStartDay.text = "Wednesday"
                    
                case 5:
                    lblStartDay.text = "Thursday"
                case 6:
                    lblStartDay.text = "Friday"
                case 7:
                    lblStartDay.text = "Saturday"
                default:
                    print("Error fetching days")
                ///  return "Day"
                }
            } else {
                print("bad input")
            }
        }
       
        if dataEvent.end_date != ""{
            let endDate = NSString.convertFormatOfDate(date: dataEvent.end_date ?? "", originalFormat: "yyyy-mm-dd", destinationFormat: "dd MMMM yyyy")
                lblEndDate.text = endDate
            
            if let weekday = UtilesSwift.shared.getDayOfWeek(endDate!) {
                print(weekday)
                switch weekday {
                case 1:
                    lblEndDay.text = "Sunday"
                case 2:
                    lblEndDay.text = "Monday"
                case 3:
                    lblEndDay.text = "Tuesday"
                case 4:
                    lblEndDay.text = "Wednesday"
                    
                case 5:
                    lblEndDay.text = "Thursday"
                case 6:
                    lblEndDay.text = "Friday"
                case 7:
                    lblEndDay.text = "Saturday"
                default:
                    print("Error fetching days")
                ///  return "Day"
                }
            } else {
                print("bad input")
            }
        }
        let formatter = DateFormatter()

        if dataEvent.start_time != "" {
        let startTime = dataEvent.start_time
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = formatter.date(from: startTime ?? "") {
            formatter.dateFormat = "hh:mm a"
            let timeStr = formatter.string(from: date)
            lblStartToTime.text = timeStr
            lblStartFromTime.text = timeStr
        }
        }
        if dataEvent.end_time != "" {
            
            
            let endTime = dataEvent.end_time
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = formatter.date(from: endTime ?? "") {
                formatter.dateFormat = "hh:mm a"
                let timeStr = formatter.string(from: date)
                lblEndToTime.text = timeStr
                lblEndFromTime.text = timeStr
            }
         

        }
    }
    func setKaizenData(dataKaizen:KaizenInfoDataModel) {
        print(dataKaizen)
        lblTitle.text = dataKaizen.title
        let imgURL = BaseURL + dataKaizen.cover_image!
        imgCover.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgCover.sd_setImage(with: URL(string:imgURL), completed: nil)
        
        if dataKaizen.start_date != ""{
            
            let startDate = NSString.convertFormatOfDate(date: dataKaizen.start_date ?? "", originalFormat: "yyyy-mm-dd", destinationFormat: "dd MMMM yyyy")
            lblStartDate.text = startDate
            
            
            if let weekday = UtilesSwift.shared.getDayOfWeek(startDate!) {
                print(weekday)
                switch weekday {
                case 1:
                  lblStartDay.text = "Sunday"
                case 2:
                    lblStartDay.text = "Monday"
                case 3:
                    lblStartDay.text = "Tuesday"
                case 4:
                    lblStartDay.text = "Wednesday"
                    
                case 5:
                    lblStartDay.text = "Thursday"
                case 6:
                    lblStartDay.text = "Friday"
                case 7:
                    lblStartDay.text = "Saturday"
                default:
                    print("Error fetching days")
                ///  return "Day"
                }
            } else {
                print("bad input")
            }
        }
       
        if dataKaizen.end_date != ""{
            let endDate = NSString.convertFormatOfDate(date: dataKaizen.end_date ?? "", originalFormat: "yyyy-mm-dd", destinationFormat: "dd MMMM yyyy")
                lblEndDate.text = endDate
            
            if let weekday = UtilesSwift.shared.getDayOfWeek(endDate!) {
                print(weekday)
                switch weekday {
                case 1:
                    lblEndDay.text = "Sunday"
                case 2:
                    lblEndDay.text = "Monday"
                case 3:
                    lblEndDay.text = "Tuesday"
                case 4:
                    lblEndDay.text = "Wednesday"
                    
                case 5:
                    lblEndDay.text = "Thursday"
                case 6:
                    lblEndDay.text = "Friday"
                case 7:
                    lblEndDay.text = "Saturday"
                default:
                    print("Error fetching days")
                ///  return "Day"
                }
            } else {
                print("bad input")
            }
        }

        
    }
    
    func setGRData(grData:GRDetail_Data){
        print(grData)
        lblTitle.text = grData.title
        let imgURL = BaseURL + grData.cover_image!
        imgCover.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgCover.sd_setImage(with: URL(string:imgURL), completed: nil)
        
        if grData.start_date != ""{
            
            let startDate = NSString.convertFormatOfDate(date: grData.start_date ?? "", originalFormat: "yyyy-mm-dd", destinationFormat: "dd MMMM yyyy")
            lblStartDate.text = startDate
            
            
            if let weekday = UtilesSwift.shared.getDayOfWeek(startDate!) {
                print(weekday)
                switch weekday {
                case 1:
                  lblStartDay.text = "Sunday"
                case 2:
                    lblStartDay.text = "Monday"
                case 3:
                    lblStartDay.text = "Tuesday"
                case 4:
                    lblStartDay.text = "Wednesday"
                    
                case 5:
                    lblStartDay.text = "Thursday"
                case 6:
                    lblStartDay.text = "Friday"
                case 7:
                    lblStartDay.text = "Saturday"
                default:
                    print("Error fetching days")
                ///  return "Day"
                }
            } else {
                print("bad input")
            }
        }
       
        if grData.end_date != ""{
            let endDate = NSString.convertFormatOfDate(date: grData.end_date ?? "", originalFormat: "yyyy-mm-dd", destinationFormat: "dd MMMM yyyy")
                lblEndDate.text = endDate
            
            if let weekday = UtilesSwift.shared.getDayOfWeek(endDate!) {
                print(weekday)
                switch weekday {
                case 1:
                    lblEndDay.text = "Sunday"
                case 2:
                    lblEndDay.text = "Monday"
                case 3:
                    lblEndDay.text = "Tuesday"
                case 4:
                    lblEndDay.text = "Wednesday"
                    
                case 5:
                    lblEndDay.text = "Thursday"
                case 6:
                    lblEndDay.text = "Friday"
                case 7:
                    lblEndDay.text = "Saturday"
                default:
                    print("Error fetching days")
                ///  return "Day"
                }
            } else {
                print("bad input")
            }
        }

        
    }
}

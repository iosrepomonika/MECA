//
//  NewDetailVM.swift


import UIKit

class NewDetailVM: BaseTableViewVM {
    let identifierCoverImgCell = "DetailCoverImageTVCell"
    let identifierLocationCell = "DetailLocationTVCell"
    let identifierAboutCell = "DetailAboutEventTVCell"
    let identifierImgesCell = "DetailImagesAndVideosCell"
    let identifierEventContentCell = "DetailEventContentTVCell"
    let identifierVideoLinkCell = "DetailVideoLinkTVCell"
    let identifierDocumentLinkCell = "DetailDocLinkTVCell"
    let identifierCommentLikeCell = "DetailCommentLikeTVCell"
    var eventData : Data_Event?
    var kaizenData : KaizenInfoDataModel?
    var GRData : GRDetail_Data?
    
    
        override init(controller: UIViewController?) {
            super.init(controller: controller)
        }
    
    
    override func getNumbersOfRows(in section: Int) -> Int {
        return 8
    }
    override func getCellForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierCoverImgCell, for: indexPath) as! DetailCoverImageTVCell
            cell.btnBackOutlet.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

            if (actualController as! NewDetailVC).isFromGR{
                if GRData != nil{
                cell.setGRData(grData: GRData!)
                }

            }else if (actualController as! NewDetailVC).isEvent{
                if eventData != nil{
                    cell.setEventData(dataEvent: eventData!)
                }

            }else{
                if kaizenData != nil{
                    cell.setKaizenData(dataKaizen: kaizenData!)
                }
            }
            return cell

        }else  if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierLocationCell, for: indexPath) as! DetailLocationTVCell
            
            return cell
            
        }else  if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierAboutCell, for: indexPath) as! DetailAboutEventTVCell
            cell.btnReadMoreOutlet.addTarget(self, action: #selector(didTapReadmoreButton), for: .touchUpInside)

            if (actualController as! NewDetailVC).isFromGR{
                if GRData != nil{
                cell.setGRData(grData: GRData!)
                }
            }else if (actualController as! NewDetailVC).isEvent{
                if eventData != nil{
                    cell.setEventData(dataEvent: eventData!)
                }

            }else{

                if kaizenData != nil{
                    cell.setKaizenData(dataKaizen: kaizenData!)
                }
            }
            return cell
            
        }else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierImgesCell, for: indexPath) as! DetailImagesAndVideosCell
            cell.detailVC = (actualController as? NewDetailVC).self
        
            if (actualController as! NewDetailVC).isFromGR{
                if GRData != nil{
                cell.setGRData(grData: GRData!)
                }
                
            }else if (actualController as! NewDetailVC).isEvent{
                if eventData != nil{
                    cell.setEventData(dataEvent: eventData!)
                }
                
            }else{

                if kaizenData != nil{
                    
                    cell.setKaizenData(dataKaizen: kaizenData!)
                }
            }
            return cell
            
        }else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierEventContentCell, for: indexPath) as! DetailEventContentTVCell
            cell.detailVC = (actualController as? NewDetailVC).self
        
            if (actualController as! NewDetailVC).isFromGR{
                if GRData != nil{
                cell.setGRData(grData: GRData!)
                }
                }else if (actualController as! NewDetailVC).isEvent{
                if eventData != nil{
                    cell.setEventData(dataEvent: eventData!)
                }
            }else{

                if kaizenData != nil{
                    cell.setKaizenData(dataKaizen: kaizenData!)
                }
            }
            return cell
        }else if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierVideoLinkCell, for: indexPath) as! DetailVideoLinkTVCell
            cell.detailVC = (actualController as? NewDetailVC).self
            if (actualController as! NewDetailVC).isFromGR{
                if GRData != nil{
                cell.setGRData(grData: GRData!)
                }
                }else if (actualController as! NewDetailVC).isEvent{
                if eventData != nil{
                    cell.setEventData(dataEvent: eventData!)
                }
            }else{

                if kaizenData != nil{
                    cell.setKaizenData(dataKaizen: kaizenData!)
                }
            }
            return cell
            
        }else if indexPath.row == 6{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierDocumentLinkCell, for: indexPath) as! DetailDocLinkTVCell
            cell.detailVC = (actualController as? NewDetailVC).self
            if (actualController as! NewDetailVC).isFromGR{
                if GRData != nil{
                    cell.setGRData(grData: GRData!)
                }
            }else if (actualController as! NewDetailVC).isEvent{
                if eventData != nil{
                    cell.setEventData(dataEvent: eventData!)
                }
            }else{

                if kaizenData != nil{
                    cell.setKaizenData(dataKaizen: kaizenData!)
                }
            }
            return cell

        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierCommentLikeCell, for: indexPath) as! DetailCommentLikeTVCell
//            if (actualController as! NewDetailVC).isEvent{
//                if eventData != nil{
//                    cell.setEventData(dataEvent: eventData!)
//                }
//            }else{
//
//                if kaizenData != nil{
//                    cell.setKaizenData(dataKaizen: kaizenData!)
//                }
//            }
            return cell
        }
        

    }
    override func didSelectRowAt(_ indexPath: IndexPath, tableView: UITableView) {
    }
  
    @objc func didTapReadmoreButton(sender:UIButton) {
        if (actualController as! NewDetailVC).isFromGR{
            if GRData?.description != ""{
            let vc = FlowController().instantiateViewController(identifier: "AboutDetailVC", storyBoard: "Category") as! AboutDetailVC
                vc.strdescrtiption = GRData?.description ?? ""
            vc.modalPresentationStyle = .fullScreen
            (actualController as! NewDetailVC).present(vc, animated: true, completion: nil)
            
        }
        }else if (actualController as! NewDetailVC).isEvent{
            if eventData?.description != ""{
            let vc = FlowController().instantiateViewController(identifier: "AboutDetailVC", storyBoard: "Category") as! AboutDetailVC
                vc.strdescrtiption = eventData?.description ?? ""
            vc.modalPresentationStyle = .fullScreen
            (actualController as! NewDetailVC).present(vc, animated: true, completion: nil)
            
        }
        }else{
            if kaizenData?.description != ""{
                let vc = FlowController().instantiateViewController(identifier: "AboutDetailVC", storyBoard: "Category") as! AboutDetailVC
                vc.strdescrtiption = kaizenData?.description ?? ""
                //vc.navigationController?.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .fullScreen

                (actualController as! NewDetailVC).present(vc, animated: true, completion: nil)
                
            }
        }
    }
    
    @objc func didTapBackButton(sender:UIButton) {
        (actualController as! NewDetailVC).navigationController?.popViewController(animated: true)
    }
    override func getHeightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
       
        if indexPath.row == 0{
            return UITableView.automaticDimension//440
        }else  if indexPath.row == 1{
            return 0//225
        }else  if indexPath.row == 2{
            return 155
        }else  if indexPath.row == 3{
            return UITableView.automaticDimension//450
        } else if indexPath.row == 4{
            if (actualController as! NewDetailVC).isFromGR{
                if GRData != nil{
                    if GRData?.event_documents != nil {
                        if (GRData?.event_documents!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
            }
            else if (actualController as! NewDetailVC).isEvent{
                if eventData != nil{
                    if eventData?.event_documents != nil {
                        if (eventData?.event_documents!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
            }else{

                if kaizenData != nil{
                    if kaizenData?.kaizen_documents != nil {
                        if (kaizenData?.kaizen_documents!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
            }
            
        }else if indexPath.row == 5{
            if (actualController as! NewDetailVC).isEvent{
                if GRData != nil{
                    if GRData?.video_links != nil {
                        if (GRData?.video_links!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
            }
            else if (actualController as! NewDetailVC).isEvent{
                if eventData != nil{
                    if eventData?.video_links != nil {
                        if (eventData?.video_links!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
            }else{
                
                if kaizenData != nil{
                    if kaizenData?.video_links != nil {
                        if (kaizenData?.video_links!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }else{
                    return 0
                }
            }
            
        }else if indexPath.row == 6{
            if (actualController as! NewDetailVC).isFromGR{
                if GRData != nil{
                    if GRData?.document_links != nil {
                        if (GRData?.document_links!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
            }else
            if (actualController as! NewDetailVC).isEvent{
                if eventData != nil{
//                    if eventData?.d != nil {
//                        if (eventData?.video_links!.count)! > 0{
//                            return UITableView.automaticDimension//150
//                        }else{
//                            return 0
//                        }
//                    }else{
                        return 0
                    //}
                }
            }else{

                if kaizenData != nil{
                    if kaizenData?.document_links != nil {
                        if (kaizenData?.document_links!.count)! > 0{
                            return UITableView.automaticDimension//150
                        }else{
                            return 0
                        }
                    }else{
                        return 0
                    }
                }
            }
            
        }else{
            return 120
        }
        return 0
    }
    
    
    
    //Api call
    
    func callEventInfoWebservice() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForEventInfo(eventID: (actualController as! NewDetailVC).eventID, isEvent: (actualController as! NewDetailVC).isEvent) { [self] (result) in
            
            if let respCode = result.resp_code{
                
                if respCode == 200{
                    
                    if let objDate = result.data {
                        
                        eventData = objDate
                        
                        GlobalObj.displayLoader(true, show: false)
                        (actualController as! NewDetailVC).tblDetailView.isHidden = false
                        (actualController as! NewDetailVC).tblDetailView.reloadData()
                    }else{
                        (actualController as! NewDetailVC).tblDetailView.isHidden = false

                        GlobalObj.displayLoader(true, show: false)
                    }
                        
                    }
                    
                    GlobalObj.displayLoader(true, show: false)
                    
                }
            }
        }
    func callKaizenInfoWebservice(completion:@escaping(Bool) -> Void) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForKaizenInfo(eventId: (actualController as! NewDetailVC).eventID) { (result) in
            if let respCode = result.resp_code{
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let objDate = result.data {
                        print(objDate)
                        self.kaizenData = objDate
                        (self.actualController as! NewDetailVC).tblDetailView.isHidden = false
                        (self.actualController as! NewDetailVC).tblDetailView.reloadData()

                      
                        completion(true)
                    }else{
                        (self.actualController as! NewDetailVC).tblDetailView.isHidden = true
                        GlobalObj.displayLoader(true, show: false)
                    }
                }

            }
        }
    }
    
    func callGRDetailWebservice() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.wevserviceForGRDetailFeed(feedId: (actualController as! NewDetailVC).eventID) { (result) in
            if let respCode = result.resp_code{
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)
                    print(GlobalValue.tabCategory)
                    if let objDate = result.data {
                        print(objDate)
                        self.GRData = objDate
                        (self.actualController as! NewDetailVC).tblDetailView.isHidden = false
                        (self.actualController as! NewDetailVC).tblDetailView.reloadData()
                        
                    }else{
                        (self.actualController as! NewDetailVC).tblDetailView.isHidden = true
                        GlobalObj.displayLoader(true, show: false)
                    }
                }else{
                    (self.actualController as! NewDetailVC).tblDetailView.isHidden = true
                    GlobalObj.displayLoader(true, show: false)

                }

            }else{
                (self.actualController as! NewDetailVC).tblDetailView.isHidden = true

                GlobalObj.displayLoader(true, show: false)
            }
        }
    }
    
    func callSdgsInfoWebservice(completion:@escaping(Bool) -> Void) {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForSdgsInfo(eventId: (actualController as! NewDetailVC).eventID) { (result) in
            
            print("sdgs details response ..\(result)")
            if let respCode = result.resp_code{
                if respCode == 200{
                    GlobalObj.displayLoader(true, show: false)

                    if let objDate = result.data {
                        print(objDate)
                        self.kaizenData = objDate
                        (self.actualController as! NewDetailVC).tblDetailView.isHidden = false

                        (self.actualController as! NewDetailVC).tblDetailView.reloadData()

                      
                        completion(true)
                    }else{
                        (self.actualController as! NewDetailVC).tblDetailView.isHidden = true
                        GlobalObj.displayLoader(true, show: false)
                    }
                }else{
                    (self.actualController as! NewDetailVC).tblDetailView.isHidden = true
                    GlobalObj.displayLoader(true, show: false)
                }

            }
        }
    }
    func callhydrogenInfoWebservice(completion:@escaping(Bool) -> Void) {
            GlobalObj.displayLoader(true, show: true)
            APIClient.webserviceForHydrogenInfo(eventId: (actualController as! NewDetailVC).eventID) { (result) in
                if let respCode = result.resp_code{
                    if respCode == 200{
                        GlobalObj.displayLoader(true, show: false)

                        if let objDate = result.data {
                            print(objDate)
                            self.kaizenData = objDate
                            (self.actualController as! NewDetailVC).tblDetailView.isHidden = false
                            (self.actualController as! NewDetailVC).tblDetailView.reloadData()

                          
                            completion(true)
                        }else{
                            (self.actualController as! NewDetailVC).tblDetailView.isHidden = true
                            GlobalObj.displayLoader(true, show: false)
                        }
                    }else{
                        (self.actualController as! NewDetailVC).tblDetailView.isHidden = true
                        GlobalObj.displayLoader(true, show: false)
                    }

                }
            }
        }
        
        func callMaasInfoWebservice(completion:@escaping(Bool) -> Void) {
            GlobalObj.displayLoader(true, show: true)
            APIClient.webserviceForMaasInfo(eventId: (actualController as! NewDetailVC).eventID) { (result) in
                if let respCode = result.resp_code{
                    if respCode == 200{
                        GlobalObj.displayLoader(true, show: false)

                        if let objDate = result.data {
                            print(objDate)
                            self.kaizenData = objDate
                            (self.actualController as! NewDetailVC).tblDetailView.isHidden = false
                            (self.actualController as! NewDetailVC).tblDetailView.reloadData()

                          
                            completion(true)
                        }else{
                            (self.actualController as! NewDetailVC).tblDetailView.isHidden = true
                            GlobalObj.displayLoader(true, show: false)
                        }
                    }else{
                        (self.actualController as! NewDetailVC).tblDetailView.isHidden = true
                        GlobalObj.displayLoader(true, show: false)
                    }

                }
            }
        }
}

/**/



import Foundation
import Alamofire
import KRProgressHUD


class APIClient {
//Login
    static func webServicesToSignIn(params:[String:Any],completion:@escaping(LoginUserModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + login
        AF.request(url, method: .post, parameters: params)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                    print("Response Error")
                    return }
                
                do{
                    let objRes: LoginUserModel = try JSONDecoder().decode(LoginUserModel.self, from: dataResponse)
//                    completion(objRes)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
}
   //Registration
    static func webServiceForSignUp(params:[String:Any],completion:@escaping(Any) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
            GlobalObj.showNetworkAlert()
            return
        }
        let url = BaseURL + register
        AF.request(url, method: .post, parameters: params)
            .responseJSON { response in
//                completion(response)
                switch response.result{
                case .success( _):
                    completion(response.value!)
                case .failure(let error):
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
    
    //DistributorList
   
    static func webServicesForDistributorList(params:[String:Any],completion:@escaping(Any) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + distributor
        AF.request(url, method: .get, parameters: params)
            .responseJSON { response in
            
                switch response.result{
                case .success( _):
                    completion(response.value!)
                case .failure(let error):
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }

               
            }
}

    //Division List
    static func webServicesForDivisionList(Division_Id:String,params:[String:Any],completion:@escaping(Any) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + divisionList+Division_Id
        AF.request(url, method: .get, parameters: params)
            .responseJSON { response in
            
                switch response.result{
                case .success( _):
                    completion(response.value!)
                case .failure(let error):
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }

               
            }
}

    //Home Feed
    
   // static func wevserviceForHomeFeed(completion:@escaping(HomeModel) -> Void){
    static func wevserviceForHomeFeed(completion:@escaping(HomeModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + homeFeed
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                    print("Response Error")
                    return }
                
                do{
                    let objRes: HomeModel = try JSONDecoder().decode(HomeModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
    
    
    //MEBIT Home
    static func webserviceForMEBITFeed(completion:@escaping(MEBITModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + mebitFeed
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                    print("Response Error")
                    return }
                
                do{
                    let objRes: MEBITModel = try JSONDecoder().decode(MEBITModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
 //Event Info
	static func webserviceForEventInfo(eventID:String, isEvent: Bool,completion:@escaping(EventInfoModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)
				GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + eventInfo + eventID

        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                    print("Response Error")
                    return }
                
                do{
                    let objRes: EventInfoModel = try JSONDecoder().decode(EventInfoModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)
                }
            }
    }
    
    //Kaizen info
	static func webserviceForKaizenInfo(eventId: String = "5",completion:@escaping(KaizenInfoModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + kaizenInfo + eventId
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                    print("Response Error")
                    return }
                
                do{
                    let objRes: KaizenInfoModel = try JSONDecoder().decode(KaizenInfoModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)
                }
            }
    }
    
    //New Car
    static func webserviceForNewCarSale(params:[String:Any],completion:@escaping(NewCarKaizenModel) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
           let url = BaseURL + kaizenList
          
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                       return }

                   do{
                       let objRes: NewCarKaizenModel = try JSONDecoder().decode(NewCarKaizenModel.self, from: dataResponse)
                       switch response.result{
                                      case .success( _):
                                              completion(objRes)
                                      case .failure(let error):
                                          print(error)
                                        GlobalObj.displayLoader(true, show: false)

                                      }
                   }catch let error{
                       print(error)
                    GlobalObj.displayLoader(true, show: false)

                   }
               }
       }

    
    //MEBIT List
    static func webserviceForMEBITList(completion:@escaping(MedbiListModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + mebitFeed
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                
                guard let dataResponse = response.data else {
                    print("Response Error")
                    return }
                
                do{
                    let objRes: MedbiListModel = try JSONDecoder().decode(MedbiListModel.self, from: dataResponse)
                    switch response.result{
                                   case .success( _):
                                           completion(objRes)
                                   case .failure(let error):
                                       print(error)
                                    GlobalObj.displayLoader(true, show: false)

                                   }
                }catch let error{
                    print(error)
                    GlobalObj.displayLoader(true, show: false)

                }
            }
    }
}

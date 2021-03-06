

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
                    GlobalObj.displayLoader(true, show: false)
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
                    GlobalObj.displayLoader(true, show: false)

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
                    GlobalObj.displayLoader(true, show: false)

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
                    GlobalObj.displayLoader(true, show: false)

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
                    GlobalObj.displayLoader(true, show: false)

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
    static func webserviceForNewCarSale(limit: String,page: String, params:[String:Any],completion:@escaping(NewCarKaizenModel) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
           let url = BaseURL + kaizenList + limit + "/" + page
          
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

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
                    GlobalObj.displayLoader(true, show: false)

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
    
    //Category list
    static func webserviceForCategoryList(completion:@escaping(MEBITCat_Model) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + categories
       
      //  var headers = HTTPHeaders()
       // let accessToken = userDef.string(forKey: UserDefaultKey.token)
        // headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: [:])
            .responseJSON { response in
                print(response)
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: MEBITCat_Model = try JSONDecoder().decode(MEBITCat_Model.self, from: dataResponse)
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
    
    
   // CategoryList Bottom
    static func webserviceForCategory(limit:String,page:String,params:[String:Any],completion:@escaping(CatListModel) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
           let url = BaseURL + eventList + limit + "/" + page
          
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                       return }

                   do{
                       let objRes: CatListModel = try JSONDecoder().decode(CatListModel.self, from: dataResponse)
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
    
    //GRLinkList
    
    static func webserviceForGRLinkList(limit: String,page: String, params:[String:Any],completion:@escaping(LinkModel) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
           let url = BaseURL + GRlinks + limit + "/" + page
          
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                       return }

                   do{
                       let objRes: LinkModel = try JSONDecoder().decode(LinkModel.self, from: dataResponse)
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
    
    //Hydrogen Info
           static func webserviceForHydrogenInfo(eventId: String = "5",completion:@escaping(KaizenInfoModel) -> Void){
            if !NetworkReachabilityManager()!.isReachable{
                GlobalObj.displayLoader(true, show: false)

                      GlobalObj.showNetworkAlert()
                      return
            }
            let url = BaseURL + HydrogenInfo + eventId
           
            var headers = HTTPHeaders()

            let accessToken = userDef.string(forKey: UserDefaultKey.token)
             headers = ["Authorization":"Bearer \(accessToken ?? "")"]
            AF.request(url, method: .get, headers: headers)
                .responseJSON { response in
                    print("Response \(response)")
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
    //GRHomeList
    
    static func webserviceForGRHomeList(limit: String,page: String,Type:String,params:[String:Any],isFromGRHome:Bool, completion:@escaping(GRHomeLisModel) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
        var url = ""
        if isFromGRHome {
             url = BaseURL + GRHomeList + limit + "/" + page
        }else{
             url = BaseURL + GRHomeList + limit + "/" + page + "/" +  Type
        }
        
           
          
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                       return }

                   do{
                       let objRes: GRHomeLisModel = try JSONDecoder().decode(GRHomeLisModel.self, from: dataResponse)
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
  
    //GR Detail
    
    static func wevserviceForGRDetailFeed(feedId:String,completion:@escaping(GRDetailModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + GRDetail + feedId
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print(response)
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: GRDetailModel = try JSONDecoder().decode(GRDetailModel.self, from: dataResponse)
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
    
    //SDGS List
    static func webserviceForSDGSlistapi(limit: String,page: String, params:[String:Any],completion:@escaping(Maasallvalue) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
           let url = BaseURL + SdgsList + limit + "/" + page
          print("kaizen\(url)")
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
                       let objRes: Maasallvalue = try JSONDecoder().decode(Maasallvalue.self, from: dataResponse)
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
    
    //Sdgs Info
       static func webserviceForSdgsInfo(eventId: String = "5",completion:@escaping(KaizenInfoModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + SdgsInfo + eventId
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print("Response \(response)")
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
    
    //Maas Info
       static func webserviceForMaasInfo(eventId: String = "5",completion:@escaping(KaizenInfoModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + MaasInfo + eventId
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print("Response \(response)")
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
    
    //maas list
    
    static func webserviceForMaas(limit: String,page: String, params:[String:Any],completion:@escaping(Maasallvalue) -> Void){
           if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                     GlobalObj.showNetworkAlert()
                     return
           }
           let url = BaseURL + MaasList + limit + "/" + page
        print("Maas \(url)")
           var headers = HTTPHeaders()

           let accessToken = userDef.string(forKey: UserDefaultKey.token)
            headers = ["Authorization":"Bearer \(accessToken ?? "")"]
//           AF.request(url, method: .post, headers: headers)
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
               .responseJSON { response in
                print(response.result)
                   guard let dataResponse = response.data else {
                       print("Response Error")
                       return }

                   do{
                    print("dataResponse \(dataResponse)")
                       let objRes: Maasallvalue = try JSONDecoder().decode(Maasallvalue.self, from: dataResponse)
                    print("objRes \(objRes)")
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
    //Hydrogen list
        
        static func webserviceForHydrogen(limit: String,page: String, params:[String:Any], completion:@escaping(Hydrogenallvalue) -> Void){
               if !NetworkReachabilityManager()!.isReachable{
                GlobalObj.displayLoader(true, show: false)

                         GlobalObj.showNetworkAlert()
                         return
               }
            //10/1
               let url = BaseURL + HydrogenList + limit + "/" + page
            print("Maas \(url)")
               var headers = HTTPHeaders()

               let accessToken = userDef.string(forKey: UserDefaultKey.token)
                headers = ["Authorization":"Bearer \(accessToken ?? "")"]
    //           AF.request(url, method: .post, headers: headers)
            AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
                   .responseJSON { response in
                    print(response.result)
                       guard let dataResponse = response.data else {
                           print("Response Error")
                           return }

                       do{
                        print("dataResponse \(dataResponse)")
                           let objRes: Hydrogenallvalue = try JSONDecoder().decode(Hydrogenallvalue.self, from: dataResponse)
                        print("objRes \(objRes)")
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
    
    
    //Like post
     static func webServiceForLikePost(params:[String:Any],completion:@escaping(Any) -> Void){
         if !NetworkReachabilityManager()!.isReachable{
             GlobalObj.displayLoader(true, show: false)
             GlobalObj.showNetworkAlert()
             return
         }
         let url = BaseURL + likeUpdate
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]

         AF.request(url, method: .post, parameters: params, headers: headers)
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
    
    
    //Comment List
    
    static func wevserviceForCommentList(module:String, item:String, completion:@escaping(CommentListModel) -> Void){
        if !NetworkReachabilityManager()!.isReachable{
            GlobalObj.displayLoader(true, show: false)

                  GlobalObj.showNetworkAlert()
                  return
        }
        let url = BaseURL + CommentList + module + "/" + item
       
        var headers = HTTPHeaders()

        let accessToken = userDef.string(forKey: UserDefaultKey.token)
         headers = ["Authorization":"Bearer \(accessToken ?? "")"]
        AF.request(url, method: .get, headers: headers)
            .responseJSON { response in
                print(response)
                guard let dataResponse = response.data else {
                    print("Response Error")
                    GlobalObj.displayLoader(true, show: false)

                    return }
                
                do{
                    let objRes: CommentListModel = try JSONDecoder().decode(CommentListModel.self, from: dataResponse)
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



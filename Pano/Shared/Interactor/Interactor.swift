//
//  Interactor.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import Alamofire

//final class Interactor: InteractorProtocol {
//    
//    func getModel<Model: Codable>(_ route: Routes,
//                                  method: Alamofire.HTTPMethod = .get,
//                                  parameters: [String : Any]? = nil,
//                                  encoding: Alamofire.URLEncoding = .queryString,
//                                  headers: Alamofire.HTTPHeaders? = nil,
//                                  onSuccess: @escaping (Model) -> Void,
//                                  onFailure: @escaping (PanoError) -> Void) {
//        
//        guard NetworkReachabilityManager()?.isReachable ?? true else {
//            onFailure(.networkIsNotReachable)
//            return
//        }
//        
//        AF.request(route.getURL(),
//                   method: method,
//                   parameters: parameters,
//                   encoding: encoding,
//                   headers: headers).responseDecodable(of: Model.self,
//                                                       queue: .global(qos: .background)) { response in
//                       if let model = response.value, response.response?.statusCode == 200 {
//                           onSuccess(model)
//                       } else {
//                           onFailure(.somethingGoesWrong)
//                       }
//                   }
//    }
//}

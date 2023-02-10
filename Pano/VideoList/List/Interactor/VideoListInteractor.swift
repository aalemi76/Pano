//
//  VideoListInteractor.swift
//  Pano
//
//  Created by AliReza on 2023-02-08.
//

import Foundation
import Alamofire

class VideoListInteractor: InteractorProtocol {
    
    typealias Model = Lessons
    
    private var cache = Cache<String, Model>()
    
    init() {
        DiskManager.shared.load(from: .cache(id: Lessons.id)) { [weak self] (cache: Cache<String, Model>)  in
            self?.cache = cache
        } onFailure: { _ in
            
        }
    }
    
    private func loadFromCache(onSuccess: @escaping (Model) -> Void,
                               onFailure: @escaping (PanoError) -> Void) {
        if let cached = cache.value(forKey: Lessons.id) {
            onSuccess(cached)
        } else {
            onFailure(.notCachedYet)
        }
    }
    
    func getModel(_ route: Routes,
                  urlString: String? = nil,
                  method: Alamofire.HTTPMethod = .get,
                  parameters: [String : Any]? = nil,
                  encoding: Alamofire.URLEncoding = .queryString,
                  headers: Alamofire.HTTPHeaders? = nil,
                  onSuccess: @escaping (Model) -> Void,
                  onFailure: @escaping (PanoError) -> Void) {
        
        guard NetworkReachabilityManager()?.isReachable ?? true else {
            loadFromCache { lessons in
                onSuccess(lessons)
            } onFailure: { _ in
                onFailure(.networkIsNotReachable)
            }
            return
        }
        
        AF.request(route.getURL(),
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers).responseDecodable(of: Model.self,
                                                       queue: .global(qos: .background))
        { [unowned self] response in
            if let model = response.value, response.response?.statusCode == 200 {
                self.cache.insert(model, forKey: Lessons.id)
                DiskManager.shared.save(self.cache, in: .cache(id: Lessons.id)) { _ in
                    
                } onFailure: { _ in
                    
                }
                onSuccess(model)
            } else {
                onFailure(.somethingGoesWrong)
            }
        }
        
    }
    
}

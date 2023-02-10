//
//  InteractorProtocol.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import Alamofire

protocol InteractorProtocol {
    
    associatedtype Model: Codable
    
    func getModel(_ route: Routes,
                  urlString: String?,
                  method: HTTPMethod,
                  parameters: [String: Any]?,
                  encoding: URLEncoding,
                  headers: HTTPHeaders?,
                  onSuccess: @escaping (Model) -> Void,
                  onFailure: @escaping (PanoError) -> Void)
    
    
}

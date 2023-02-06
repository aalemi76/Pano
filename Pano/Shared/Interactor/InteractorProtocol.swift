//
//  InteractorProtocol.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import Alamofire

protocol InteractorProtocol {
    
    func getModel< Model: Codable >(_ route: Routes,
                                    method: HTTPMethod,
                                    parameters: [String: Any]?,
                                    encoding: URLEncoding,
                                    headers: HTTPHeaders?,
                                    onSuccess: @escaping (Model) -> Void,
                                    onFailure: @escaping (PanoError) -> Void)
    
    
}

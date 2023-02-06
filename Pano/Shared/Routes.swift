//
//  Routes.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import Foundation

enum Routes: String {
    
    case lessons = "lessons"
    
    var baseURL: String {
        get {
            return "https://iphonephotographyschool.com/test-api"
        }
    }
    
    func getURL() -> String {
        return "\(self.baseURL)/\(self.rawValue)"
    }
}

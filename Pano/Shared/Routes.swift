//
//  Routes.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import Foundation

enum Routes: String {
    
    case lessons = "lessons"
    case videoURL
    
    var baseURL: String {
        get {
            return "https://iphonephotographyschool.com/test-api"
        }
    }
    
    func getURL() -> String {
        return "\(self.baseURL)/\(self.rawValue)"
    }
    
    func getVideoURL(forLesson lesson: Lesson) -> String {
        return lesson.videoURL
    }
}

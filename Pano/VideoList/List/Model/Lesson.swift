//
//  Lesson.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import Foundation

struct Lesson: Codable {
    let id: Int
    let name, description: String
    let thumbnail: String
    let videoURL: String

    enum CodingKeys: String, CodingKey {
        case id, name, description, thumbnail
        case videoURL = "video_url"
    }
}

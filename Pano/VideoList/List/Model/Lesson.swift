//
//  Lesson.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import UIKit

struct Lessons: Codable {
    static let id = "25A8DB5A-A4F8-4907-9BCB-64F59333149F"
    let lessons: [Lesson]
    
}

class Lesson: Codable, Hashable {
    
    let id: Int
    let name, description: String
    let thumbnail: String
    let videoURL: String

    enum CodingKeys: String, CodingKey {
        case id, name, description, thumbnail
        case videoURL = "video_url"
    }
    
    init(id: Int, name: String, description: String, thumbnail: String, videoURL: String) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.videoURL = videoURL
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.thumbnail, forKey: .thumbnail)
        try container.encode(self.videoURL, forKey: .videoURL)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.videoURL = try container.decode(String.self, forKey: .videoURL)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        lhs.id == rhs.id
    }
}

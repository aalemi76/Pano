//
//  DiskManager.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import Foundation

enum DocumentDirectory {
    case cache(id: String)
    case library(id: Int)
    func getPath() -> URL {
        switch self {
        case .cache(let id):
            return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathExtension(id + ".cache")
        case .library(let id):
            return FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0].appendingPathExtension("\(id)" + ".mp4")
        }
    }
}

class DiskManager {
    
    static let shared = DiskManager()
    
    func save(_ object: Codable,
              in directory: DocumentDirectory,
              onSuccess: @escaping (Bool) -> Void,
              onFailure: @escaping (Error) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let path = directory.getPath()
            do {
                if FileManager.default.fileExists(atPath: path.absoluteString) {
                    try FileManager.default.removeItem(atPath: path.absoluteString)
                }
                
                if let data = object as? Data {
                    try data.write(to: path)
                    onSuccess(true)
                } else {
                    let data = try JSONEncoder().encode(object)
                    try data.write(to: path)
                    onSuccess(true)
                }
            } catch {
                onFailure(error)
            }
        }
    }
    
    func load<Model: Codable>(from directory: DocumentDirectory,
                              onSuccess: @escaping (Model) -> Void,
                              onFailure: @escaping (Error) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let path = directory.getPath()
            do {
                let data = try Data(contentsOf: path)
                let object = try JSONDecoder().decode(Model.self, from: data)
                onSuccess(object)
            } catch {
                onFailure(error)
            }
        }
    }
}

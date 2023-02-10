//
//  PanoError.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import Foundation

enum PanoError: String, Error {
    case networkIsNotReachable = "Ooops...! Device seems to be offline!"
    case somethingGoesWrong = "Ooops...! Something goes wrong!"
    case notCachedYet = "Ooops...! Items have not been cached before!"
    case saveVideoError = "Ooops...! an error occured while saving the video!"
}

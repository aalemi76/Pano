//
//  Viewable.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import Foundation

protocol Viewable: AnyObject {
    func show(result: Result<Any, PanoError>)
}

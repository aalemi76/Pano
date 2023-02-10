//
//  Reusable.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import Foundation

protocol Reusable: AnyObject {
    init(reuseID: String, cellClass: AnyClass, model: Any)
    func getReuseID() -> String
    func getCellClass() -> AnyClass
    func getModel() -> Any
    func updateModel(model: Any)
    func cellDidLoad(_ cell: Updatable)
}

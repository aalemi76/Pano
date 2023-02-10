//
//  Updatable.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import Foundation

protocol Updatable: AnyObject {
    
    func attach(viewModel: Reusable)
    
    func update(model: Any)
}

//
//  SharedCellViewModel.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import Foundation

class SharedCellViewModel: Reusable {
    
    let reuseID: String
    let cellClass: AnyClass
    var model: Any
    
    required init(reuseID: String, cellClass: AnyClass, model: Any) {
        self.reuseID = reuseID
        self.cellClass = cellClass
        self.model = model
    }
    
    func getReuseID() -> String { return reuseID}
    
    func getCellClass() -> AnyClass { return cellClass }
    
    func getModel() -> Any { return model }
    
    func updateModel(model: Any) {
        self.model = model
    }
    
    func cellDidLoad(_ cell: Updatable) {
        return
    }
}

//
//  SectionProvider.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import UIKit

class SectionProvider: Sectionable {
    
    var title: String?
    private var cells: [Reusable]
    private var headerView: UIView?
    private var footerView: UIView?
    
    required init(title: String?, cells: [Reusable], headerView: UIView?, footerView: UIView?) {
        self.title = title
        self.cells = cells
        self.headerView = headerView
        self.footerView = footerView
    }
    
    func getCells() -> [Reusable] { return cells }
    func getHeaderView() -> UIView? { return headerView }
    func getFooterView() -> UIView? { return footerView }
    
    func append(_ cells: [Reusable]) {
        self.cells += cells
    }
    
    func removeCells() {
        cells.removeAll()
    }
}

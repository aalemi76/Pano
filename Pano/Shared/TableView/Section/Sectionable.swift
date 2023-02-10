//
//  Sectionable.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import UIKit

protocol Sectionable: AnyObject {
    var title: String? { get }
    init(title: String?, cells: [Reusable], headerView: UIView?, footerView: UIView?)
    func getCells() -> [Reusable]
    func getHeaderView() -> UIView?
    func getFooterView() -> UIView?
    func append(_ cells: [Reusable])
    func removeCells()
}


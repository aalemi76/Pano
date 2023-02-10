//
//  TableViewProviderProtocol.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import UIKit

protocol TableViewProviderProtocol: AnyObject, UITableViewDelegate, UITableViewDataSource  {
    
    var sections: [Sectionable] { get set }
    
    var tableView: UITableView { get }
    
    init(tableView: UITableView, sections: [Sectionable])
    
    func registerSections(_ sections: [Sectionable])
    func load(_ sections: [Sectionable])
    func reloadItems(at indexPaths: [IndexPath])
    func reloadSections(sections: IndexSet)
    
}
extension TableViewProviderProtocol {
    
    func registerSections(_ sections: [Sectionable]) {
        sections.forEach { (section) in
            section.getCells().forEach { (reusable) in
                let nibCell = UINib(nibName: reusable.getReuseID(), bundle: nil)
                tableView.register(nibCell, forCellReuseIdentifier: reusable.getReuseID())
            }
        }
    }
    
    func load(_ sections: [Sectionable]) {
        self.sections = sections
        registerSections(sections)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func reloadItems(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
    func reloadSections(sections: IndexSet) {
        tableView.reloadSections(sections, with: .automatic)
    }
    
}


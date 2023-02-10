//
//  TableViewProvider.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import UIKit
import Combine

class TableViewProvider: UIView, TableViewProviderProtocol {
    
    var passSelectedItem = PassthroughSubject<Any, Never>()
    
    var sections: [Sectionable]
    
    var tableView: UITableView
    
    required init(tableView: UITableView, sections: [Sectionable]) {
        self.tableView = tableView
        self.sections = sections
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
}

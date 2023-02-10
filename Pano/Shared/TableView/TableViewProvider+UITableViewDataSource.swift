//
//  TableViewProvider+UITableViewDataSource.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import UIKit

extension TableViewProvider: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].getCells().count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].getCells()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.getReuseID(), for: indexPath)
        cell.selectionStyle = .none
        (cell as? Updatable)?.attach(viewModel: item)
        (cell as? Updatable)?.update(model: item.getModel())
        return cell
    }
    
}

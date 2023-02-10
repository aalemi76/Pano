//
//  TableViewProvider+UITableViewDelegate.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import UIKit

extension TableViewProvider: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = sections[section].getHeaderView()
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = sections[section].getFooterView()
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = sections[indexPath.section].getCells()[indexPath.row].getModel()
        passSelectedItem.send(item)
    }
}

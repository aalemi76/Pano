//
//  VideoDetailViewController+Viewable.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import Foundation

extension VideoDetailViewController: Viewable {
    
    func show(result: Result<Any, PanoError>) {
        switch result {
        case .success(let sections):
            guard let sections = sections as? [Sectionable] else { return }
            tableViewProvider.load(sections)
        case .failure(let error):
            showErrorBanner(title: error.localizedDescription)
        }
    }
    
    
}

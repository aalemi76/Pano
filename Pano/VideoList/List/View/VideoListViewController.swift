//
//  VideoListViewController.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import UIKit
import SwiftUI

class VideoListViewController: UIViewController {
    let contentView: UIHostingController<VideoListView>
    
    init(contentView: UIHostingController<VideoListView>) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalSettings.shared.darkGray
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(contentView)
        view.addSubview(contentView.view)
        NSLayoutConstraint.activate([
            contentView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        contentView.didMove(toParent: self)
    }
}

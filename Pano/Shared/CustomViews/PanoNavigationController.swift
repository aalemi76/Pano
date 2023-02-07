//
//  PanoNavigationController.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import UIKit

class PanoNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationStyles()
    }
    
    func setupNavigationStyles() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = GlobalSettings.shared.darkGray
        appearance.titleTextAttributes = [.foregroundColor: GlobalSettings.shared.purple ?? .white,
                                          .font: GlobalSettings.shared.getFont(withType: .bold, ofSize: 20)]
        appearance.largeTitleTextAttributes = [.foregroundColor: GlobalSettings.shared.purple ?? .white,
                                               .font: GlobalSettings.shared.getFont(withType: .bold, ofSize: 30)]
        navigationBar.tintColor = .white
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    
}

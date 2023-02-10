//
//  PanoNavigationController.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import UIKit

class PanoNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalSettings.shared.darkGray
        setupNavigationStyles()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    func setupNavigationStyles() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = GlobalSettings.shared.darkGray
        appearance.titleTextAttributes = [.foregroundColor: GlobalSettings.shared.purple ?? .white,
                                          .font: GlobalSettings.shared.getFont(withType: .bold, ofSize: 20)]
        appearance.largeTitleTextAttributes = [.foregroundColor: GlobalSettings.shared.purple ?? .white,
                                               .font: GlobalSettings.shared.getFont(withType: .bold, ofSize: 30)]
        navigationBar.tintColor = GlobalSettings.shared.purple
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    
    
}

//
//  VideoDetailViewController.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import UIKit
import Combine

class VideoDetailViewController: UIViewController {
    
    var willDisappear: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
    var didTapOnDownload: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
    @objc func barButtonItemDidTap() {
        didTapOnDownload.send(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(image: UIImage(systemName: "icloud.and.arrow.down"),
                        style: .plain, target: self,
                        action: #selector(barButtonItemDidTap))
    }
    
    override func viewDidLoad() {
        view.backgroundColor = GlobalSettings.shared.darkGray
        super.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        willDisappear.send(true)
    }
}

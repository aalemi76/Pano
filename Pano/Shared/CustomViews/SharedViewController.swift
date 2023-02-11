//
//  SharedViewController.swift
//  Pano
//
//  Created by AliReza on 2023-02-10.
//

import UIKit
import Combine

class SharedViewController: UIViewController {
    
    var infoView: InformationView?
    
    var cancellableStorage = Set<AnyCancellable>()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = GlobalSettings.shared.purple
        spinner.backgroundColor = GlobalSettings.shared.darkGray
        spinner.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
        spinner.layer.cornerRadius = 20
        spinner.layer.masksToBounds = true
        spinner.layer.borderWidth = 1
        spinner.layer.borderColor = GlobalSettings.shared.darkGray?.cgColor ?? UIColor(named: "black")?.cgColor
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    func showLoadingView() {
        dismissLoadingView()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.addSubview(self.loadingView)
            self.loadingView.center = self.view.center
            UIView.animate(withDuration: 2, delay: 0.5, options: [.curveEaseInOut], animations: {
                self.loadingView.startAnimating()
            })
        }
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loadingView.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
    func showSuccessBanner(title: String) {
        DispatchQueue.main.async { [weak self] in
            self?.infoView?.removeFromSuperview()
            self?.infoView = InformationView()
            self?.infoView?.setInformation(description: title, type: .success)
        }
    }
    
    func showErrorBanner(title: String) {
        DispatchQueue.main.async { [weak self] in
            self?.infoView?.removeFromSuperview()
            self?.infoView = InformationView()
            self?.infoView?.setInformation(description: title, type: .failure)
        }
    }
    
}

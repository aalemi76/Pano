//
//  PlayerTableViewCell.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import UIKit
import AVKit

class PlayerTableViewCell: UITableViewCell, Updatable {
    
    static let reuseID = String(describing: PlayerTableViewCell.self)
    
    private lazy var playerViewController: AVPlayerViewController = {
        let vc = AVPlayerViewController()
        vc.view.backgroundColor = GlobalSettings.shared.darkGray
        return vc
    }()

    private var player = AVPlayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    func attach(viewModel: Reusable) {
        return
    }
    
    func update(model: Any) {
        guard let urlString = (model as? Lesson)?.videoURL, let url = URL(string: urlString) else { return }
        player.pause()
        player = AVPlayer(url: url)
        playerViewController.player = player
        player.playImmediately(atRate: 1)
        return
    }
    
    private func setupLayout() {
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playerViewController.view)
        NSLayoutConstraint.activate([
            playerViewController.view.topAnchor.constraint(equalTo: topAnchor),
            playerViewController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerViewController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerViewController.view.bottomAnchor.constraint(equalTo: bottomAnchor),
            playerViewController.view.heightAnchor.constraint(greaterThanOrEqualToConstant: 220)])
    }
}

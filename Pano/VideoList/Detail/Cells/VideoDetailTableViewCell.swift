//
//  VideoDetailTableViewCell.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import UIKit

enum Title {
    case title
    case description
}

class VideoDetailTableViewCell: UITableViewCell, Updatable {
    
    static let reuseID = String(describing: VideoDetailTableViewCell.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    func attach(viewModel: Reusable) {
        return
    }
    
    func update(model: Any) {
        guard let model = model as? (type: Title, text: String) else { return }
        titleLabel.text = model.text
        switch model.type {
        case .title:
            titleLabel.font = GlobalSettings.shared.getFont(withType: .bold, ofSize: 20)
        case .description:
            titleLabel.font = GlobalSettings.shared.getFont(withType: .regular, ofSize: 15)
        }
        return
    }
    
    private func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)])
    }
    
}

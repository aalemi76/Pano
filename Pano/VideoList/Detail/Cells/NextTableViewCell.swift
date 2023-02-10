//
//  NextTableViewCell.swift
//  Pano
//
//  Created by AliReza on 2023-02-10.
//

import UIKit

class NextTableViewCell: UITableViewCell, Updatable {
    
    static let reuseID = String(describing: NextTableViewCell.self)
    
    weak var viewModel: NextTableCellViewModel?
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next lesson", for: .normal)
        button.setTitleColor(GlobalSettings.shared.purple, for: .normal)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
//        button.imageView = UIImageView(image: )
        button.titleLabel?.font = GlobalSettings.shared.getFont(withType: .regular ,ofSize: 15)
        button.tintColor = GlobalSettings.shared.purple
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    func attach(viewModel: Reusable) {
        self.viewModel = viewModel as? NextTableCellViewModel
    }
    
    func update(model: Any) {
        return
    }
    
    @objc func didTapOnNextButton() {
        self.viewModel?.didTapOnNextButton.send(true)
    }
    
    private func setupLayout() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            nextButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 10)])
        nextButton.addTarget(self, action: #selector(didTapOnNextButton), for: .touchUpInside)
    }
    
}

//
//  InformationView.swift
//  Pano
//
//  Created by AliReza on 2023-02-10.
//

import UIKit

class InformationView: UIView {
    
    enum InfoType {
        case failure
        case success
    }
    
    private let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = GlobalSettings.shared.getFont(withType: .medium, ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureFrame()
        addTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureFrame() {
        guard let window = UIApplication.shared.keyWindow?.windowScene?.windows.first else { return }
        frame = CGRect(x: 0, y: -100, width: window.bounds.width, height: 100)
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        window.addSubview(self)
    }
    
    private func addTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)])
    }
    
    func setInformation(description: String, type: InfoType) {
        title.text = description
        let time: TimeInterval
        switch type {
        case .failure:
            backgroundColor = GlobalSettings.shared.red
            title.textColor = GlobalSettings.shared.darkGray
            time = 5
        case .success:
            backgroundColor = .white
            title.textColor = GlobalSettings.shared.darkGray
            time = 3
        }
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 2, delay: 0, options: [.transitionCrossDissolve], animations: {
                self?.center.y += 100
            })
        }
        dismiss(time: time)
    }
    
    func dismiss(time: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) { [weak self] in
            UIView.animate(withDuration: 2, delay: 0, options: [.transitionCrossDissolve], animations: {
                self?.center.y -= 100
            }) { _ in
                self?.removeFromSuperview()
            }
        }
    }
    
}

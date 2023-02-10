//
//  VideoDetailViewController.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import UIKit
import Combine

class VideoDetailViewController: UIViewController {
    
    private let viewModel: VideoDetailViewModel
    
    init(viewModel: VideoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var willDisappear: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
    var didTapOnDownload: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.separatorColor = .none
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
        return tableView
    }()
    
    lazy var tableViewProvider = TableViewProvider(tableView: tableView, sections: [])
    
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
        super.viewDidLoad()
        setupLayout()
        viewModel.viewDidLoad(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        willDisappear.send(true)
    }
    
    private func setupLayout() {
        view.backgroundColor = GlobalSettings.shared.darkGray
        tableViewProvider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableViewProvider)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
}

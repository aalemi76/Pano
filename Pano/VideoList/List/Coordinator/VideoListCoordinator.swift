//
//  VideoListCoordinator.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import UIKit
import SwiftUI
import Combine

class VideoListCoordinator: VideoListCoordinatorProtocol {
    
    // MARK: - Properties
    
    var didFinish: PassthroughSubject<Coordinator, Never>
    
    var type: CoordinatorType
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator]
    
    var cancellableStorage: Set<AnyCancellable>
    
    // MARK: - Initializer
    
    required init(type: CoordinatorType, navigationController: UINavigationController) {
        didFinish = PassthroughSubject()
        self.type = type
        self.navigationController = navigationController
        childCoordinators = []
        cancellableStorage = Set()
    }
    
    // MARK: - Methods
    
    func start() {
        let view = VideoListView(viewModel: VideoListViewModel(interactor: VideoListInteractor()))
        let contentView = UIHostingController(rootView: view)
        let viewController = VideoListViewController(contentView: contentView)
        viewController.title = "Lessons"
        view.didSelectLesson.sink { [weak self] lesson in
            self?.showVideoDetail(for: lesson)
        }.store(in: &cancellableStorage)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showVideoDetail(for lesson: Lesson) {
        let viewController = VideoDetailViewController()
        viewController.willDisappear.sink { [weak self] _ in
            self?.navigationController.navigationBar.prefersLargeTitles = true
        }.store(in: &cancellableStorage)
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
}

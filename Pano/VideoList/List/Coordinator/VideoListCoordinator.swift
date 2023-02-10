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
        view.didSelectLesson.sink { [weak self] lessons, index in
            self?.showVideoDetail(for: lessons, index: index)
        }.store(in: &cancellableStorage)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showVideoDetail(for lessons: [Lesson], index: Int?) {
        guard let index = index else { return }
        let viewModel = VideoDetailViewModel(lessons: lessons, currentIndex: index)
        let viewController = VideoDetailViewController(viewModel: viewModel)
        viewController.willDisappear.sink { [weak self] _ in
            self?.navigationController.navigationBar.prefersLargeTitles = true
        }.store(in: &cancellableStorage)
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
}

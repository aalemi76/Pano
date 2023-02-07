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
        let interactor = Interactor()
        let viewModel = VideoListViewModel(interactor: interactor)
        let view = VideoListView(viewModel: viewModel)
        view.didSelectLesson.sink { [weak self] lesson in
            self?.showVideoDetail(for: lesson)
        }.store(in: &cancellableStorage)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(UIHostingController(rootView: view), animated: true)
    }
    
    func showVideoDetail(for lesson: Lesson) {
        print(lesson.name)
        return
    }
    
    
}

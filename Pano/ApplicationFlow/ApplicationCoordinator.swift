//
//  ApplicationCoordinator.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import UIKit
import Combine

class ApplicationCoordinator: Coordinator {
    
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
        let coorinator = VideoListCoordinator(type: .videoList, navigationController: navigationController)
        coorinator.didFinish.sink { _ in
            // TODO: - When the video list coordinator finishes!
        }.store(in: &cancellableStorage)
        childCoordinators.append(coorinator)
        coorinator.start()
    }
    
}

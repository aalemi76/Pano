//
//  Coordinator.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import UIKit
import Combine

// MARK: - Coordinator Type Enum

enum CoordinatorType {
    case app, videoList
}

// MARK: - Coordinator Protocol

protocol Coordinator: AnyObject {
    
    var didFinish: PassthroughSubject<Coordinator, Never> { get set }
    
    var type: CoordinatorType { get }
    
    var navigationController: UINavigationController { get set }
    
    var childCoordinators: [Coordinator] { get set }
    
    var cancellableStorage: Set<AnyCancellable> { get set }
    
    init(type: CoordinatorType, navigationController: UINavigationController)
    
    func start()
    
    func push(viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func present(viewController: UIViewController, animated: Bool)
    func dimiss(viewController: UIViewController, animated: Bool)
    
    func end()
    
}

// MARK: - Default Implementations

extension Coordinator {
    
    func push(viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool) {
        navigationController.present(viewController, animated: true, completion: nil)
    }
    
    func dimiss(viewController: UIViewController, animated: Bool) {
        viewController.dismiss(animated: animated, completion: nil)
    }
    
    func end() {
        childCoordinators.removeAll()
        didFinish.send(self)
    }
}


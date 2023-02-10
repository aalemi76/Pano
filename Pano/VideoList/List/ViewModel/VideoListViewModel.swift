//
//  VideoListViewModel.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import Foundation

final class VideoListViewModel: ObservableObject, ViewModelProtocol {
    
    private var interactor: VideoListInteractor
    @Published var lessons = [Lesson]()
    @Published var isFetching = false
    @Published var error: PanoError?
    private var isFirstTime = true
    
    init(interactor: any InteractorProtocol) {
        self.interactor = interactor as! VideoListInteractor
    }

    func viewDidLoad(_ view: Viewable? = nil) {
        getItems()
    }
    
    private func getItems() {
        guard isFirstTime else { return }
        isFetching = true
        interactor.getModel(.lessons) { [weak self] (lessons: Lessons) in
            DispatchQueue.main.async {
                self?.isFetching = false
                self?.isFirstTime = false
                self?.lessons.append(contentsOf: lessons.lessons)
            }
        } onFailure: { [weak self] error in
            DispatchQueue.main.async {
                self?.isFetching = false
                self?.error = error
            }
        }

    }
    
}

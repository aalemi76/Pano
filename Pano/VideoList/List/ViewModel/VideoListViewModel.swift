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
    
    init(interactor: any InteractorProtocol) {
        self.interactor = interactor as! VideoListInteractor
    }

    func viewDidLoad() {
        getItems()
    }
    
    private func getItems() {
        isFetching = true
        interactor.getModel(.lessons) { [weak self] (lessons: Lessons) in
            DispatchQueue.main.async {
                self?.isFetching = false
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

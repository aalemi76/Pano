//
//  VideoListViewModel.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import Foundation

final class VideoListViewModel: ObservableObject {
    
    @Published var lessons = []
    @Published var isFetching = false
    
    private let interactor = Interactor()
    
    func getItems() {
        isFetching = true
        interactor.getModel(.lessons) { [unowned self] (lessons: [Lesson]) in
            self.isFetching = false
            self.lessons.append(contentsOf: lessons)
        } onFailure: { error in
            self.isFetching = false
            print(error.rawValue)
        }

    }
    
}

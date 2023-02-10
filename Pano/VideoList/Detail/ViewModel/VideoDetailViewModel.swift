//
//  VideoDetailViewModel.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import Foundation

class VideoDetailViewModel: ViewModelProtocol {
    
    var lessons: [Lesson]
    var currentIndex: Int
    
    init(lessons: [Lesson], currentIndex: Int) {
        self.lessons = lessons
        self.currentIndex = currentIndex
    }
    
    func viewDidLoad() {
        let sections = createSections()
        return
    }
    
    func loadNextLesson() -> [Sectionable] {
        currentIndex += 1
        return createSections()
    }
    
    func createSections() -> [Sectionable] {
        let lesson = lessons[currentIndex]
        let player = SectionProvider(title: nil,
                                     cells: [SharedCellViewModel(reuseID: "",
                                                                 cellClass: Lesson.self, model: lesson.videoURL)],
                                     headerView: nil,
                                     footerView: nil)
        let title = SectionProvider(title: nil,
                                    cells: [SharedCellViewModel(reuseID: "",
                                                                cellClass: Lesson.self, model: lesson.name)],
                                    headerView: nil,
                                    footerView: nil)
        let description = SectionProvider(title: nil,
                                                      cells: [SharedCellViewModel(reuseID: "",
                                                                                  cellClass: Lesson.self, model: lesson.description)],
                                                      headerView: nil,
                                                      footerView: nil)
        return [player, title, description]
    }
}

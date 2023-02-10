//
//  VideoDetailViewModel.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import Foundation
import Combine

class VideoDetailViewModel: ViewModelProtocol {
    
    var lessons: [Lesson]
    var currentIndex: Int
    
    weak var view: Viewable?
    
    private var cancellableStorage = Set<AnyCancellable>()
    
    init(lessons: [Lesson], currentIndex: Int) {
        self.lessons = lessons
        self.currentIndex = currentIndex
    }
    
    func viewDidLoad(_ view: Viewable?) {
        self.view = view
        let sections = createSections()
        view?.show(result: .success(sections))
    }
    
    func loadNextLesson() {
        if currentIndex >= lessons.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
        let sections = createSections()
        view?.show(result: .success(sections))
    }
    
    func createSections() -> [Sectionable] {
        
        let lesson = lessons[currentIndex]
        
        let player = SectionProvider(title: nil,
                                     cells: [SharedCellViewModel(reuseID: PlayerTableViewCell.reuseID,
                                                                cellClass: PlayerTableViewCell.self,
                                                                model: lesson)],
                                     headerView: nil,
                                     footerView: nil)
        
        let title = SectionProvider(title: nil,
                                    cells: [SharedCellViewModel(reuseID: VideoDetailTableViewCell.reuseID,
                                                                cellClass: VideoDetailTableViewCell.self,
                                                                model: (Title.title, lesson.name))],
                                    headerView: nil,
                                    footerView: nil)
        
        let description = SectionProvider(title: nil,
                                          cells: [SharedCellViewModel(reuseID: VideoDetailTableViewCell.reuseID,
                                                                      cellClass: VideoDetailTableViewCell.self,
                                                                      model: (Title.description, lesson.description))],
                                          headerView: nil,
                                          footerView: nil)
        
        let nextButtonViewModel = NextTableCellViewModel(reuseID: NextTableViewCell.reuseID, cellClass: NextTableViewCell.self, model: "")
        didTapOnNextButton(cellViewModel: nextButtonViewModel)
        let nextCell = SectionProvider(title: nil, cells: [nextButtonViewModel], headerView: nil, footerView: nil)
        
        return [player, title, description, nextCell]
    }
    
    func didTapOnNextButton(cellViewModel: NextTableCellViewModel) {
        cellViewModel.didTapOnNextButton.sink { [weak self] _ in
            self?.loadNextLesson()
        }.store(in: &cancellableStorage)
    }
}

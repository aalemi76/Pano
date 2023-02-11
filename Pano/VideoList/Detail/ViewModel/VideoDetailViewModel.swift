//
//  VideoDetailViewModel.swift
//  Pano
//
//  Created by AliReza on 2023-02-09.
//

import Foundation
import Combine
import Alamofire

enum DownloadState: String {
    case downloaded = ""
    case download = "icloud.and.arrow.down"
    case downloading = "stop.circle"
    case resume = "play.circle"
}

class VideoDetailViewModel: ViewModelProtocol {
    
    private var interactor = VideoDetailInteractor()
    
    private var lessons: [Lesson]
    private var currentIndex: Int
    private var downloadState: DownloadState {
        didSet {
            (view as? VideoDetailViewController)?.didChangeDownloadState(downloadState)
        }
    }
    
    private var progress: Float = 0 {
        didSet {
            (view as? VideoDetailViewController)?.didChangeProgress(progress)
        }
    }
    
    private weak var view: Viewable?
    
    private var cancellableStorage = Set<AnyCancellable>()
    
    init(lessons: [Lesson], currentIndex: Int) {
        self.lessons = lessons
        self.currentIndex = currentIndex
        downloadState = .download
    }
    
    func viewDidLoad(_ view: Viewable?) {
        self.view = view
        let sections = createSections()
        view?.show(result: .success(sections))
        (view as? VideoDetailViewController)?.didTapOnDownload.sink(receiveValue: { [weak self] _ in
            self?.downloadVideo()
        }).store(in: &cancellableStorage)
    }
    
    private func loadNextLesson() {
        if currentIndex >= lessons.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
        let sections = createSections()
        view?.show(result: .success(sections))
    }
    
    private func didTapOnNextButton(cellViewModel: NextTableCellViewModel) {
        cellViewModel.didTapOnNextButton.sink { [weak self] _ in
            self?.loadNextLesson()
        }.store(in: &cancellableStorage)
    }
    
    private func downloadVideo() {
        switch downloadState {
        case .download:
            downloadState = .downloading
            let urlString = lessons[currentIndex].videoURL
            interactor.getModel(.videoURL, urlString: urlString) { [weak self] progress in
                if progress == 1 {
                    self?.downloadState = .downloaded
                }
                self?.progress = Float(progress)
            } onFailure: { [weak self] error in
                self?.view?.show(result: .failure(error))
            }
        case .downloading:
            downloadState = .resume
            interactor.cancelDownload()
        case .resume:
            downloadState = .downloading
            interactor.resumeDownload { [weak self] progress in
                if progress == 1 {
                    self?.downloadState = .downloaded
                }
                self?.progress = Float(progress)
            } onFailure: { [weak self] error in
                self?.view?.show(result: .failure(error))
            }
        default:
            return
        }
    }
    
    private func checkLessonState(_ lesson: Lesson) -> String {
        
        interactor.id = lesson.id
        
        var urlString: String
        
        if let url = interactor.loadVideo() {
            urlString = url.absoluteString
            downloadState = .downloaded
            progress = 1
        } else {
            urlString = lesson.videoURL
            downloadState = .download
            progress = 0
        }
        
        return urlString
        
    }
    
    private func createSections() -> [Sectionable] {
        
        let lesson = lessons[currentIndex]
        
        let urlString = checkLessonState(lesson)
        
        let player = SectionProvider(title: nil,
                                     cells: [SharedCellViewModel(reuseID: PlayerTableViewCell.reuseID,
                                                                 cellClass: PlayerTableViewCell.self,
                                                                 model: urlString)],
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
}

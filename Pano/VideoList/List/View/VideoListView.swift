//
//  VideoListView.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import SwiftUI
import Combine

struct VideoListView: View {
    
    @StateObject var viewModel: VideoListViewModel
    
    var didSelectLesson = PassthroughSubject<Lesson, Never>()
    
    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.lessons, id: \.id) { lesson in
                    VideoCell(model: lesson).onTapGesture {
                        didSelectLesson.send(lesson)
                    }
                }.listStyle(.plain)
                    .background(Color("darkGray"))
            }.navigationTitle("Lessons")
                .onAppear { viewModel.viewDidLoad() }
        }
    }
}

struct VideoListViewPreviews: PreviewProvider {
    static var previews: some View {
        let interactor = VideoListInteractor()
        let viewModel = VideoListViewModel(interactor: interactor)
        VideoListView(viewModel: viewModel)
    }
}

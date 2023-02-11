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
    
    var didSelectLesson = PassthroughSubject<([Lesson], Int?), Never>()
    
    var body: some View {
        ZStack {
            List(viewModel.lessons, id: \.id) { lesson in
                VideoCell(model: lesson).onTapGesture {
                    let index = viewModel.lessons.firstIndex(of: lesson)
                    didSelectLesson.send((viewModel.lessons, index))
                }
            }.listStyle(.plain)
                .background(Color("darkGray"))
        }.onAppear {
            viewModel.viewDidLoad()
        }.background(Color("darkGray"))
    }
}

struct VideoListViewPreviews: PreviewProvider {
    static var previews: some View {
        let interactor = VideoListInteractor()
        let viewModel = VideoListViewModel(interactor: interactor)
        VideoListView(viewModel: viewModel)
    }
}

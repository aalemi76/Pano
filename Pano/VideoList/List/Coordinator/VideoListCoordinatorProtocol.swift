//
//  VideoListCoordinatorProtocol.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import Foundation

protocol VideoListCoordinatorProtocol: Coordinator {
    func showVideoDetail(for lesson: Lesson)
}

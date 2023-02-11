//
//  VideoDetailInteractor.swift
//  Pano
//
//  Created by AliReza on 2023-02-10.
//

import Foundation
import Alamofire

class VideoDetailInteractor: InteractorProtocol {
   
    typealias Model = Double
    
    var download: DownloadRequest?
    
    var data: Data?
    
    var id: Int = 0
    
    func saveVideo(data: Data,
                   onSuccess: @escaping () -> Void,
                   onFailure: @escaping (PanoError) -> Void) {
        
        DiskManager.shared.save(data, in: .library(id: id)) { _ in
            onSuccess()
        } onFailure: { error in
            print(error)
            onFailure(.saveVideoError)
        }

        
    }
    
    func loadVideo() -> URL? {
        let directory = DocumentDirectory.library(id: id)
        if DiskManager.shared.checkExistance(directory: directory) {
            return directory.getPath()
        } else {
            return nil
        }

    }
    
    func cancelDownload() {
        download?.cancel { [weak self] data in
            self?.data = data
        }
    }
    
    func getModel(_ route: Routes,
                  urlString: String?,
                  method: Alamofire.HTTPMethod = .get,
                  parameters: [String : Any]? = nil,
                  encoding: Alamofire.URLEncoding = .queryString,
                  headers: Alamofire.HTTPHeaders? = nil,
                  onSuccess: @escaping (Double) -> Void,
                  onFailure: @escaping (PanoError) -> Void) {
        
        let progressQueue = DispatchQueue(label: "com.alamofire.progressQueue", qos: .utility)
        
        if let urlString = urlString {
            download = AF.download(urlString)
                .downloadProgress(queue: progressQueue) { progress in
                    onSuccess(progress.fractionCompleted)
                }
                .responseData { [weak self] response in
                    if let data = response.value {
                        self?.data = data
                        self?.saveVideo(data: data, onSuccess: {
                            
                        }, onFailure: { error in
                            onFailure(error)
                        })
                    }
                }
        } else if let data = data {
            download = AF.download(resumingWith: data)
                .downloadProgress(queue: progressQueue) {progress in
                    onSuccess(progress.fractionCompleted)
                }
                .responseData { [weak self] response in
                    if let data = response.value {
                        self?.data = data
                        self?.saveVideo(data: data, onSuccess: {
                            
                        }, onFailure: { error in
                            onFailure(error)
                        })
                    }
                }
        }
    }
    
    
}

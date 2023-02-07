//
//  VideoCell.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import SwiftUI
import SDWebImageSwiftUI

struct VideoCell: View {
    let model: Lesson
    
    var body: some View {
        HStack(spacing: 3) {
            WebImage(url: URL(string: model.thumbnail))
                .resizable()
                .frame(width: 120, height: 90, alignment: .center)
                .cornerRadius(5)
            VStack(alignment: .leading, spacing: 5) {
                Text(model.name)
                    .font(.body)
                    .foregroundColor(.white)
            }.padding(.leading)
            Spacer()
            Image(systemName: "chevron.forward")
                .foregroundColor(Color("purple"))
        }.listRowBackground(Color("darkGray"))
    }
}

struct VideoCell_Previews: PreviewProvider {
    
    static var previews: some View {
        VideoCell(model: Lesson(id: 950, name: "The Key To Success In iPhone Photography", description: "What’s the secret to taking truly incredible iPhone photos? Learning how to use your iPhone camera is very important, but there’s something even more fundamental to iPhone photography that will help you take the photos of your dreams! Watch this video to learn some unique photography techniques and to discover your own key to success in iPhone photography!", thumbnail: "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560", videoURL: "https://embed-ssl.wistia.com/deliveries/cc8402e8c16cc8f36d3f63bd29eb82f99f4b5f88/accudvh5jy.mp4"))
    }
    
}

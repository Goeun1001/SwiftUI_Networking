//
//  File.swift
//  MoyaEx
//
//  Created by GoEun Jeong on 2021/04/02.
//  Copyright © 2021 jge. All rights reserved.
//

import SwiftUI

struct imageView: View {

    let url: String
    @ObservedObject private var imageDownloader: ImageDownloader = ImageDownloader()

    init(url: String) {
        self.url = url
        self.imageDownloader.downloadImage(url: self.url)
    }

    var body: some View {
        if let imageData = self.imageDownloader.downloadedData {
            let img = UIImage(data: imageData)
            return VStack {
                Image(uiImage: img!)
                    .resizable()
            }
        } else {
            return VStack {
                Image(systemName: "rays")
                    .resizable()
            }
        }
    }
}

struct imageView_Previews: PreviewProvider {
    static var previews: some View {
        imageView(url: "https://interactive-examples.mdn.mozilla.net/media/examples/grapefruit-slice-332-332.jpg")
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}

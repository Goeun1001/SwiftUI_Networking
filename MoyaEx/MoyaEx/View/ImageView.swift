//
//  ImageView.swift
//  MoyaEx
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
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
        if let imageData = self.imageDownloader.downloadedImage {
            return VStack {
                Image(uiImage: imageData)
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

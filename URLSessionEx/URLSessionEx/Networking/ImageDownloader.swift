//
//  ImageDownloader.swift
//  URLSessionEx
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class ImageDownloader: ObservableObject {
    @Published var downloadedData: Data?

    func downloadImage(url: String) {
        guard let imageURL = URL(string: url) else {
            fatalError("Invalid URL")
        }

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.downloadedData = data
            }
        }
    }
}

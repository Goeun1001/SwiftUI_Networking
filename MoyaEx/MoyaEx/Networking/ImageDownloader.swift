//
//  ImageDownloader.swift
//  MoyaEx
//
//  Created by GoEun Jeong on 2021/04/02.
//  Copyright © 2021 jge. All rights reserved.
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

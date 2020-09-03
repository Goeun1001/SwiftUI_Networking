//
//  Image.swift
//  MoyaEx
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Kingfisher

class ImageDownloader: ObservableObject {
    @Published var downloadedData: Data?
    @Published var downloadedImage: UIImage?

    func downloadImage(url: String) {
        guard let imageURL = URL(string: url), downloadedImage == nil else { return }
        KingfisherManager.shared.retrieveImage(with: imageURL) { result in
            switch result {
            case .success(let imageResult):
                self.downloadedImage = imageResult.image
            case .failure:
                break
            }
        }
    }
}

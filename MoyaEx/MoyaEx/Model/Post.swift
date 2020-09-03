//
//  Post.swift
//  MoyaEx
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

// MARK: - Post
struct Post: Decodable {
    let id: Int
    let title, content, imagePath: String

    enum CodingKeys: String, CodingKey {
        case id, title, content, imagePath
    }
}

//
//  PostViewModel.swift
//  URLSessionEx
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import Combine

class PostViewModel: ObservableObject {
    @Published var posts = [Post]()

    @Published var title = ""
    @Published var content = ""
    @Published var imagePath = ""

    let postService: PostService

    func load() {
        postService.getAllPosts { posts in
            self.posts = posts ?? [Post(id: 0, title: "Failed", content: "Failed", imagePath: "")]
        }
    }

    func create() {
        postService.create(title: title, content: content, imagePath: imagePath) { _ in

        }
    }

    init() {
        self.postService = PostService()
    }

}

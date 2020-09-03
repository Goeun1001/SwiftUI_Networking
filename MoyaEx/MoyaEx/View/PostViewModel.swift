//
//  PostListView.swift
//  MoyaEx
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import Moya
import SwiftUI
import Combine

class PostViewModel: ObservableObject {
    @Published var posts = [Post]()

    @Published var title = ""
    @Published var content = ""
    @Published var imagePath = ""

    func load() {
        let provider = MoyaProvider<PostService>()
        provider.request(.getPosts) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let posts = try filteredResponse.map([Post].self)
                    self.posts = posts
                    self.objectWillChange.send()
                } catch let error {
                     print("Error: \(error)")
                }
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }

    func create() {
        let provider = MoyaProvider<PostService>()
        provider.request(.createPost(title: title, content: content, imagePath: imagePath)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    _ = try moyaResponse.filterSuccessfulStatusCodes()
                    print("create succeed")
                } catch let error {
                     print("Error: \(error)")
                }
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }

}

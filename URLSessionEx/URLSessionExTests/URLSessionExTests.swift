//
//  URLSessionExTests.swift
//  URLSessionExTests
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import XCTest
@testable import URLSessionEx

class URLSessionExTests: XCTestCase {
    let apiURL = URL(string: "http://127.0.0.1:8000/post/")!

    func test_get_should_return_data() {
        var posts = [Post]()
        let url = apiURL

        URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else { return }
            let dataList = try! JSONDecoder().decode([Post].self, from: data)
            DispatchQueue.main.async {
                posts = dataList
            }
            XCTAssertNotNil(posts, "Where is data?")
            XCTAssertNil(error, "Whoops, error \(error!.localizedDescription)")
            XCTAssertNotNil(response, "No response")
            let httpResponse = response as? HTTPURLResponse
            XCTAssertEqual(200, httpResponse?.statusCode)
        }.resume()
    }

    func test_PostService_get() {
        let postService = PostService()
        postService.getAllPosts { posts in
            XCTAssertEqual(1, posts![1].id)
            XCTAssertEqual("First Post", posts![1].title)

            XCTAssertEqual(2, posts![2].id)
        }
    }

}

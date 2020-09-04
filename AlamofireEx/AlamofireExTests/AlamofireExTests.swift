//
//  AlamofireExTests.swift
//  AlamofireExTests
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import XCTest
import Alamofire
@testable import AlamofireEx

class AlamofireExTests: XCTestCase {
    func testAlamofire() {
        let e = expectation(description: "Alamofire")
        let urlString = "http://127.0.0.1:8000/post/"

        AF.request(urlString)
            .response { response in
                XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")

                XCTAssertNotNil(response, "No response")
                XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")

                e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testPostService() {
        let postService = PostService()
        postService.getAllPosts { posts in
            XCTAssertNotNil(posts, "No response posts")
        }
    }
}

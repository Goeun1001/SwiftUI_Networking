//
//  MoyaExTests.swift
//  MoyaExTests
//
//  Created by jge on 2020/09/04.
//  Copyright © 2020 jge. All rights reserved.
//

import XCTest
import Moya
@testable import MoyaEx

class MoyaExTests: XCTestCase {
    var provider: MoyaProvider<PostService>!

    func testSuccess() {
        provider = MoyaProvider<PostService>(endpointClosure: customSuccessEndpoint, stubClosure: MoyaProvider.immediatelyStub)

        provider.request(.getPosts) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    XCTAssertNotNil(filteredResponse.data, "No data")
                    let posts = try filteredResponse.map(Post.self)

                    XCTAssertEqual(0, posts.id)
                    XCTAssertEqual("Test", posts.title)
                    XCTAssertEqual("Testimage", posts.imagePath)

                } catch let error {
                    print("Error: \(error)")
                }
            case .failure:
                break
            }
        }
    }

    func testFailed() {
        provider = MoyaProvider<PostService>(endpointClosure: customFailedEndpoint, stubClosure: MoyaProvider.immediatelyStub)

        provider.request(.getPosts) { result in
            switch result {
            case .success: break

            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }

    func test_realMoya() {
        let provider = MoyaProvider<PostService>()
        provider.request(.getPosts) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let posts = try filteredResponse.map([Post].self)

                    XCTAssertEqual(1, posts[0].id)
                    XCTAssertEqual("First Post", posts[0].title)

                } catch let error {
                    XCTAssertNil(error)
                }
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
    }

    func test_ViewModelLoad() {
        let viewModel = PostViewModel()
        viewModel.load()
        XCTAssertNotNil(viewModel.posts)
    }

    func customSuccessEndpoint(_ target: PostService) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }

    func customFailedEndpoint(_ target: PostService) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }

}

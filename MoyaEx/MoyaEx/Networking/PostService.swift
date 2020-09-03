//
//  PostService.swift
//  MoyaEx
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Moya

enum PostService {
    case getPosts
    case createPost(title: String, content: String, imagePath: String)
}

extension PostService: TargetType {

    var baseURL: URL { return URL(string: "http://127.0.0.1:8000")! }

    var path: String {
        switch self {
        case .getPosts:
            return "/post/"
        case .createPost:
            return "/post/"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getPosts:
            return .get
        case .createPost:
            return .post
        }
    }

    // 테스트 시 쓸 가짜 데이터
    var sampleData: Data {
        return "".data(using: .utf8)!
    }

    // 기본요청(plain request), 데이터 요청(data request), 파라미터 요청(parameter request), 업로드 요청(upload request) 등
    var task: Task {
        switch self {
        case .getPosts:
            return .requestPlain
        case let .createPost(title, content, imagePath):
            return .requestParameters(parameters: ["title": title, "content": content, "imagePath": imagePath], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    // HTTP code가 200에서 299사이인 경우 요청이 성공한 것으로 간주된다.
    public var validationType: ValidationType {
      return .successCodes
    }

}

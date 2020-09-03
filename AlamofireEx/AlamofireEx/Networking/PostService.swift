//
//  PostService.swift
//  AlamofireEx
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Alamofire

class PostService {
    func getAllPosts(completion: @escaping ([Post]?) -> Void) {

        AF.request("http://127.0.0.1:8000/post/").responseJSON {response in
            guard let data = response.data else {return}
            do {
                guard let posts = try? JSONDecoder().decode([Post].self, from: data) else {return}
                completion(posts)
            }
        }
    }

    func create(title: String, content: String, imagePath: String, completion: @escaping (postResponse?) -> Void) {

        let parameter = [
            "title": title,
            "content": content,
            "imagePath": imagePath
        ]

        AF.request("http://127.0.0.1:8000/post/", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default).responseJSON { request in
            guard let data = request.data, request.error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            let response = try? JSONDecoder().decode(postResponse.self, from: data)
            DispatchQueue.main.async {
                completion(response)
            }

            switch request.response?.statusCode {
            case 200:
                print("Main 200")
            default:
                print("default")
            }
        }
    }

}

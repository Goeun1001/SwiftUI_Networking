//
//  PostService.swift
//  URLSessionEx
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class PostService {
    var posts = [Post]()

    func getAllPosts() {
        guard let url = URL(string: "http://127.0.0.1:8000/post/") else { return }

        URLSession.shared.dataTask(with: url) {
            (data, _, _) in
            guard let data = data else { return }

            let dataList = try! JSONDecoder().decode([Post].self, from: data)

            DispatchQueue.main.async {
                self.posts = dataList
            }
        }.resume()
    }

    func getAllPosts(completion: @escaping ([Post]?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/post/") else { return }

        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { [weak self] data, res, err in
            guard self != nil else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode {

            case 200:
                print("Detail 200")
                guard let data = data else { return }

                let posts = try? JSONDecoder().decode([Post].self, from: data)
                if let post = posts {
                    DispatchQueue.main.async {
                        completion(post)
                    }

                } else {
                    completion(nil)
                }

            default:
                DispatchQueue.main.async {
                    print((res as! HTTPURLResponse).statusCode)
                }
            }
        }.resume()
    }

    func create(title: String, content: String, imagePath: String, completion: @escaping (postResponse?) -> Void) {

        let parameters = ["title": title, "content": content, "imagePath": imagePath]

        guard let url = URL(string: "http://127.0.0.1:8000/post/") else {return}

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }

        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in

            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            let response = try? JSONDecoder().decode(postResponse.self, from: data)
            DispatchQueue.main.async {
                completion(response)
            }
        }.resume()
    }
}

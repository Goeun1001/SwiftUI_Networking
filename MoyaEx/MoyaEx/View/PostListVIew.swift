//
//  PostListVIew.swift
//  MoyaEx
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import Moya

struct PostListView : View {
    @ObservedObject var viewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            List(self.viewModel.posts, id: \.id) { post in
                ContentView(post: post)
            }
            .onAppear(perform: self.viewModel.load)
            .navigationBarTitle(Text("All Posts"))
            .navigationBarItems(trailing:
                NavigationLink(destination: AddView()) {
                    Image(systemName: "plus")
                        .frame(width: 30, height: 30)
                }
            )
        }
    }
}

struct PostListView_Previews : PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}

struct ContentView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            imageView(url: post.imagePath)
                .frame(width: 100, height: 100, alignment: .center)
            
            Text(String(post.id))
            Text(post.title).font(.headline)
        }
    }
}

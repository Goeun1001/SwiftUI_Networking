//
//  AddView.swift
//  AlamofireEx
//
//  Created by jge on 2020/09/03.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var viewModel = PostViewModel()

    var body: some View {
        VStack(spacing: 10) {
            TextField("제목", text: $viewModel.title)
            TextField("내용", text: $viewModel.content)
            TextField("이미지", text: $viewModel.imagePath)
            Text("생성").frame(width: 100, height: 50)
                .onTapGesture {
                    self.viewModel.create()
            }
        }.padding(.leading, 30)
            .padding(.trailing, 30)

    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

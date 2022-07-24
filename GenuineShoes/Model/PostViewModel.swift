//
//  PostViewModel.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/24.
//

import Foundation

struct PostViewModel {
    private let post: PostModel
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    var caption: String {
        return post.caption
    }
    
    
    init(post: PostModel) {
        self.post = post
    }
}

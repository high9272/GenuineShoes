//
//  PostViewModel.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/24.
//

import Foundation

struct PostViewModel {
    let post: PostModel
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    var caption: String {
        return post.caption
    }
    var likes: Int {
        return post.likes
    }
    
    var likesLabelText: String {
        if post.likes != 1 {
            return "\(post.likes) likes"
        }else {
            return "\(post.likes) like"
        }
    }
    
    
    init(post: PostModel) {
        self.post = post
    }
}

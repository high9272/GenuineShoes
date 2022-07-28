//
//  PostModel.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/21.
//

import Foundation
import Firebase
import FirebaseFirestore

struct PostModel {
    var caption: String
    var likes: Int
    let imageUrl: String
    let ownerUid: String
    let timestamp : Timestamp
    let postId: String
    var didlike = false
    
    init(postId: String, dictionary: [String:Any]) {
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.postId = postId
        
    }
    
    
    
    
}

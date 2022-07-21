//
//  PostService.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/20.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


let collectionPost = Firestore.firestore().collection("posts")

struct PostService {
    static func uploadPost(caption: String, image: UIImage, completion: @escaping(String) -> Void ) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption, "timestamp": Timestamp(date: Date()), "likes": 0, "imageurl": imageUrl, "owneruid": uid, ] as [String : Any]
            
            collectionPost.addDocument(data: data)
        }

    }
    
}
